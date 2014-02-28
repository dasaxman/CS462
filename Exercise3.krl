ruleset rotten_tomatoes {
    meta {
        name "Rotten Tomatoes Exercise"
        description <<
            Rotten Tomatoes
        >>
        author "Riley Monson"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    global {
        getMovie = function(title) {
            http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
                {"apikey": "cypttkxj8w2rpb4zk8faytr3",
                 "q": title,
                 "page_limit": "1"}
            ).pick("$.content").decode();
        };
    }
    rule HelloWorld is active{
        select when web cloudAppSelected
        pre {
            form = <<
                    <div id="movieInfo"></div>
                    <p>Please input the movie title</p>
                    <form id="myForm">
                    <label for="movieTitle">Movie Title</label><input id="movieTitle" name="movieTitle"><br>
                    <input type="submit" id="formSubmit">
                    </form>
                    >>;
            testMovie = http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
                {"apikey": "cypttkxj8w2rpb4zk8faytr3",
                 "q": "Elesyium",
                 "page_limit": "1"}
            ).pick("$.content").decode().pick("$.movies[0].title");
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Rotten Tomatoes", {}, form);
            watch("#myForm", "submit");
notify("Test", testMovie);
        }
    }
    rule submit_rule {
        select when web submit "#myForm"
        pre {
            json = getMovie(event:attr("movieTitle"));
            jsonTotal = json.pick("$.total");
            jsonTitle = json.pick("$.movies[0].title");
            jsonYear = json.pick("$.movies[0].year");
            jsonSynopsis = json.pick("$.movies[0].synopsis");
            jsonRating = json.pick("$.movies[0].ratings.critics_rating");
            jsonThumbnail = json.pick("$.movies[0].posters.thumbnail");
            movieInfo = <<
                            <div id="movieInfo">
                                <div>Movie Information</div>
                                <div>
                                    <img src="#{jsonThumbnail}">
                                </div>
                                <div>
                                    Title: #{jsonTitle}<br>
                                    Release Year: #{jsonYear}<br>
                                    Synopsis: #{jsonSynopsis}<br>
                                    Critic Rating: #{jsonRating}
                                </div>
                            </div>
                        >>;
            movieError = <<
                        <div id="movieInfo" style="clear:both">
                            No movies found matching that name
                        </div>
                    >>;
        }
        replace_html("#movieInfo", movieError);
        if jsonTotal != 0 then replace_html("#movieInfo", movieInfo);
    }
}

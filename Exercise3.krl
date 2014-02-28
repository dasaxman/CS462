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
                 "page_limit": 1}
            );
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
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Rotten Tomatoes", {}, form);
            watch("#myForm", "submit");
        }
    }
    rule submit_rule {
        select when web submit "#myForm"
        pre {
            json = getMovie(event:attr("movieTitle"));
            jsonTitle = json.pick("$..title[0]");
            jsonYear = json.pick("$..year[0]");
            jsonSynopsis = json.pick("$..synopsis[0]");
            jsonRating = json.pick("$..critics_rating[0]");
            movieInfo = <<
                            <div id="movieInfo">
                                Movie Information<br>
                                Title: #{jsonTitle}<br>
                                Release Year: #{jsonYear}<br>
                                Synopsis: #{jsonSynopsis}<br>
                                Critic Rating: #{jsonRating}
                            </div>
                        >>;
        }
        {
        replace_html("#movieInfo", movieInfo);
        notify("Title", event:attr("movieTitle"));
        notify("JSON", json);
        }
    }
}

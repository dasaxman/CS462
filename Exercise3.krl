ruleset rotten_tomatoes {
    meta {
        name "Rotten Tomatoes Exercise"
        author "Riley Monson"
        logging off
    }
    global {
        getMovie = function(title) {
            http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
                {"apiKey": "cypttkxj8w2rpb4zk8faytr3",
                 "q": title,
                 "page_limit": 1}
            );
        };
    }
    rule HelloWorld is active{
        select when web cloudAppSelected
        pre {
            form = <<
                    <p>Here is my paragraph text. How lame is this?</p><br>
                    <form id="myForm">
                    <label for="firstName">First Name</label><input id="firstName" name="firstName"><br>
                    <label for="lastName">Last Name</label><input id="lastName" name="lastName"><br>
                    <input type="submit" id="formSubmit">
                    </form>
                    >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Rotten Tomatoes", {}, form);
        }
    }
}

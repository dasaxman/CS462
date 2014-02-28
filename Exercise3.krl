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
    rule basic_rule {
        select when pageview ".*"
        {
            notify("Notification 1", "Hi there.") with sticky = true and position = "top-left";
            notify("Notification 2", "Yeah, you.") with sticky = true;
        }
    }
    
}

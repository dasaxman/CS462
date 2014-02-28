ruleset rotten_tomatoes {
    meta {
        name "Rotten Tomatoes Exercise"
        author "Riley Monson"
        logging off
    }
    global {
        
    }
    rule basic_rule {
        select when pageview ".*"
        {
            notify("Notification 1", "Hi there.") with sticky = true and position = "top-left";
            notify("Notification 2", "Yeah, you.") with sticky = true;
        }
    }
    
}

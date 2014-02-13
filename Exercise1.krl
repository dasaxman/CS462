ruleset Exercise1 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
    }
    dispatch {
        // domain "exampley.com"
    }
    rule first_rule {
        select when pageview ".*" setting ()
        // Display notification that will not fade.
        {
            notify("Notification 1", "Hi there!") with sticky = true and position = "top-left";
            notify("Notification 2", "Yeah, I said hello") with sticky = true;
        }
    }
}

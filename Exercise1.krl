ruleset Exercise1 {
    meta {
        name "notify example"
        author "Riley Monson"
        logging off
    }
    dispatch {
        // domain "exampley.com"
    }
    rule first_rule {
        select when pageview ".*"
        {
            notify("Notification 1", "Hi there") with sticky = true and position = top-left;
        }
    }
}

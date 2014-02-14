ruleset Exercise1 {
    meta {
        name "notify example"
        author "Riley Monson"
        logging off
    }
    dispatch {
    }
    rule first_rule {
        select when pageview ".*"
        pre {
            name = (page:url("query") neq "") => page:url("query") | "Monkey";
        }
        {
            notify("Notification 1", "Hi there.") with sticky = true and position = "top-left";
            notify("Notification 2", "Yeah, you.") with sticky = true;
            notify("Notification 2", "Hello " + name) with sticky = true and position = "bottom-right";
        }
    }
}

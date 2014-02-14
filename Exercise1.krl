ruleset Exercise1 {
    meta {
        name "notify example"
        author "Riley Monson"
        logging off
    }
    global {
        query_name = function(query) {
            array = query.extract(re/name=(\w+)\&?/i);
            (array.length() > 0) => array[0] | "Monkey";
        }
    }
    rule first_rule {
        select when pageview ".*"
        pre {
            name = query_name(page:url("query"));
        }
        {
            notify("Notification 1", "Hi there.") with sticky = true and position = "top-left";
            notify("Notification 2", "Yeah, you.") with sticky = true;
            notify("Notification 3", "Hello " + name) with sticky = true and position = "bottom-right";
        }
    }
}

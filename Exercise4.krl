ruleset foursquare {
    meta {
        name "Foursquare Exercise"
        description <<
            Foursquare
        >>
        author "Riley Monson"
        logging off
    }
    global {
    }
    rule process_fs_checkin {
        select when foursquare checkin
        pre {
        }
        notify("Notification 1", "Hi there.");
    }
}

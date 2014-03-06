ruleset foursquare {
    meta {
        name "Foursquare Exercise"
        description <<
            Foursquare
        >>
        author "Riley Monson"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    rule HelloWorld is active {
        select when web cloudAppSelected
        pre {
            my_html = <<
              <h5>Hello, World!</h5>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Foursquare", {}, my_html);
        }
    }
    rule process_fs_checkin {
        select when foursquare checkin
        notify("Notification 1", "Hi there.");
    }
}

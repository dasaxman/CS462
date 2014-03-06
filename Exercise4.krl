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
    rule init {
        select when web cloudAppSelected
        pre {
            my_html = <<
              <div id="header">Hello, World!</div>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Foursquare", {}, my_html);
        }
    }
    rule process_fs_checkin {
        select when foursquare checkin
        pre {
            html = <<
                    <h5>Event Fired!<h5>
                    >>;
        }
        replace_html("#header", html);
    }
}

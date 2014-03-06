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
    rule display_checkin {
        select when web cloudAppSelected
        pre {
            event = ent:fsEvent;
            test = ent:test;
            my_html = <<
              <div id="content">
                Test:#{test}<br>
                Event:#{event}<br>
                Venue:#{ent:venue}<br>
                City:#{ent:city}<br>
                Shout:#{ent:shout}<br>
                Created:#{ent:created}
              </div>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Foursquare", {}, my_html);
        }
    }
    
    rule process_fs_checkin {
        select when foursquare checkin
        fired {
            set ent:test "Fired";
            set ent:fsEvent event:attrs();
        }
    }
}

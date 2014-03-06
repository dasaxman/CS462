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
            my_html = <<
              <div id="content">
                Event:#{ent:fsEvent}<br>
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
        noop();
        fired {
            set ent:fsEvent event:attr("checkin");
            set ent:venue event:attr("checkin").pick("$.venue.name");
            set ent:city event:attr("checkin").pick("$.venue.location.city");
            set ent:shout event:attr("checkin").pick("$.shout");
            set ent:created event:attr("checkin").pick("$.createdAt");
        }
    }
}

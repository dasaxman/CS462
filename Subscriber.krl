ruleset subscriber1 {
    meta {
        name "Subscriber"
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
    rule process_location_notification {
      select when location notification
      pre {
        venue = event:attr("venue");
        city = event:attr("city");
        shout = event:attr("shout");
        created = event:attr("created");
      }
      noop();
      fired {
        set ent:venue venue;
        set ent:city city;
        set ent:shout shout;
        set ent:created created;
      }
    }
}

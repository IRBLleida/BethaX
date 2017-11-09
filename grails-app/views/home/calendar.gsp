<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div id="calendar"></div>

<content tag="footScripts">
<g:javascript>
    $(function() {
        $('#calendar').fullCalendar({
            // put your options and callbacks here
            'firstDay': 1,
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            eventSources: [
                {
                    url: '${createLink(controller: 'milestone', action: 'ajaxList')}',
                    type: 'POST',
                    allDay: true,
                    color: '#65a9d7',    // an option!
                    textColor: '#3c3d3d'  // an option!
                }
            ]
        })
    });
</g:javascript>
</content>
</body>
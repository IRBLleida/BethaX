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
            googleCalendarApiKey: 'AIzaSyDPa-N4zqD7C7cyc4XfsNASSiCknq8nyQI',
            eventSources: [
                {
                    url: '${createLink(controller: 'milestone', action: 'ajaxList')}',
                    type: 'POST',
                    allDay: true,
                    color: '#65a9d7',    // an option!
                    textColor: '#3c3d3d'  // an option!
                },
                {
                    googleCalendarId: '5705kqh2ajrsqfmocaojr7fpvs@group.calendar.google.com',
                    color: 'orange',
                    className: 'gcalEvent'
                }
            ],
            eventAfterAllRender: function() {
                $('.gcalEvent').attr('target', '_blank');
            }
        });
    });
</g:javascript>
</content>
</body>

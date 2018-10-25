<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="alert alert-secondary" role="alert">
    Nota: Les fites en que estàs involucrat apareixen en <b style="color: #6AA84F">verd</b>. La resta en <b style="color: #65a9d7;">blau</b>!
</div>
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
                    textColor: '#fff'
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

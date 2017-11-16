<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script>
        function pagination()
        {
            var vars = {};
            var x = document.location.search.substring(1).split('&');
            for (var i in x)
            {
                var z = x[i].split('=', 2);
                vars[z[0]] = unescape(z[1]);
            }
            x = ['frompage','topage','page','webpage','section','subsection','subsubsection'];
            for (i in x)
            {
                var y = document.getElementsByClassName(x[i]);
                for (var j = 0; j < y.length; ++j)
                {
                    y[j].textContent = vars[x[i]];
                }
            }
        }
    </script>
</head>

<body id="pdf-footer" onload="pagination()" style="width: 100%; font-size: 4em;">
<hr />
<span class="copyright pull-left">
    Data d'impressió: <g:formatDate date="${new Date()}" format="dd/MM/yyyy HH:mm" />
</span>
<span class="page pull-right">
</span>
</body>
</html>
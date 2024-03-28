<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${path}/resources/css/mainPage.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <title>MoPot</title>
</head>
<body>
    <!-- 헤더 부분 -->
    <jsp:include page="/WEB-INF/views/Common/header.jsp" />

    <!-- 메인 홈페이지 본문 -->
    <div class="container">
        <div class="wrapper">
            <div id="typing">

            </div>
        </div>
    </div>

    <!-- 푸터 부분 -->
    <jsp:include page="/WEB-INF/views/Common/footer.jsp" />


    <script>
        $(function () {
            var textOpts = ["MoPot ", "모여라 팟! ", "MoPot ", "모여라 팟! ", "MoPot ", "모여라 팟! "],
                timeOut,
                len = textOpts.length,
                $writer = $('#typing'),
                currentValue = 0, charVal = 0,
                cursor = '<span class="cursor"> |</span>',
                lengths = [];

            $.each(textOpts, function (index, value) {
                lengths.push(value.length);
            });

            function typeAnimationIt() {
                var humanize = Math.round(Math.random() * (200 - 30)) + 30;

                timeOut = setTimeout(function () {
                    charVal++;

                    var txtLen = lengths[currentValue],
                        type = textOpts[currentValue].substring(0, charVal);

                    $writer.html(type + cursor);

                    typeAnimationIt();

                    if (charVal == txtLen) {
                        clearTimeout(timeOut);
                        if (currentValue < len - 1) {
                            setTimeout(function () {
                                typeAnimationDelete();
                            }, 1000);
                        }
                    }
                }, humanize);
            }

            function typeAnimationDelete() {
                var humanize = Math.round(Math.random() * (200 - 30)) + 30;

                timeOut = setTimeout(function () {
                    charVal--;

                    var type = textOpts[currentValue].substring(0, charVal);
                    $writer.html(type + cursor);

                    typeAnimationDelete();

                    if (charVal == 0) {
                        clearTimeout(timeOut);
                        currentValue++;
                        setTimeout(function () {
                            typeAnimationIt();
                        }, 1000);
                    }
                }, humanize);
            }

            typeAnimationIt();
        });
    </script>
</body>
</html>
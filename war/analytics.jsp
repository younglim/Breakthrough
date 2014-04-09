<%

    String loggedUser = (String) session.getAttribute("current_userID");
    
    if (request.getAttribute("facebook")!=null) {
        loggedUser = "Facebook";
    } else if (loggedUser != null) {

    } else {
        
        
        loggedUser = "Anonymous";
    }
%>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-49580682-1', 'eternal-unity-517.appspot.com');
  ga('send', 'pageview', {
        'dimension1': '<%=loggedUser%>'
    });
</script>





(function() {

    try{
      window.opener.login();
      window.close();
      return;
    }catch(e){
    }

    location = '/';

})();


$(function(){

  //radio-namespace
  $('input:radio[name="input_namesapce"]').change(function() {
    setAllCmd();
  });

  //radio-service
  $('input:radio[name="input_service"]').change(function() {
    setAllCmd();
  });

  setAllCmd();

  $('#btn_listCmd').click(function() {
    copyListPod();
  });

});


function setAllCmd() {

  var valNamespace = $('input:radio[name="input_namesapce"]:checked').val();
  console.log("namespace=" + valNamespace);

  var valService = $('input:radio[name="input_service"]:checked').val();
  console.log("service=" + valService);

  if (valNamespace!=undefined && valService!=undefined) {
    var cmdListPod = "kubectl get pods -n namespace-a-m-tw-" + valNamespace + "-01 | grep 'deployment-" + valService + "01'";
    $("#input_listCmd").val(cmdListPod);
  }

}


function copyListPod() {
  $('#input_listCmd').select();
  document.execCommand("Copy");
  window.getSelection().empty();
}
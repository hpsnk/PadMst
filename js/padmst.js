$(function () {
  $.getJSON('json/skillcategory.json') // json読み込み開始
    .done(function (jsonObj) { // jsonの読み込みに成功した時
      $.each(jsonObj, function (i, sc) {
        console.log(sc);
        $("#skillcategory").append($("<option>").html(sc.categoryName).val(sc.skillType));
      })
    })
    .fail(function () { // jsonの読み込みに失敗した時
      console.log('失敗');
    })
    .always(function () { // 成功/失敗に関わらず実行
      console.log('必ず実行される');
    });
});

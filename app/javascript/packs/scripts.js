$( document ).ready(function() {
  $('body').on('click','img',function(){
    $('#thumbnail-img').find('img').attr('src', $(this).attr('src'));
    $('#thumbnail-img').find('a').attr('href', $(this).attr('src'));
    $('.pt.active').attr('class','');
    $(this).parent().attr('class','pt active');
  });
});


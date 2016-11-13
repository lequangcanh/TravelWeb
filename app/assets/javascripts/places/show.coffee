$(document).on 'turbolinks:load', ->
  $('.slider-for').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    fade: true,
    asNavFor: '.slider-nav'
  })
  $('.slider-nav').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    asNavFor: '.slider-for',
    focusOnSelect: true,
  })
  $('#new_place_comment input[type=submit]').click (e)->
    e.preventDefault()
    $commentForm = $('#new_place_comment')
    data = JSON.stringify($commentForm.serializeArray())
    $.post($commentForm.attr('action'), data: data)
      .done((response)->
        $commentForm.find('textarea').val('')
        $commentRow = $('.sample-comment').clone()
        $commentRow.find('.username strong').text(response.user.name)
        $commentRow.find('.content').text(response.comment.content)
        $commentRow.removeAttr('style')
        $commentRow.removeClass('sample-comment')
        $commentRow.prependTo($('.comment-posts'))
      )

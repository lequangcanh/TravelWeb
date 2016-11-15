$(document).on 'turbolinks:load', ->
  $('.slider-nav').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    focusOnSelect: true,
    variableWidth: true,
    centerMode: true
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

  $('.represent-image').click ->
    $('#images-modal').modal('show')

  $('#images-modal').on 'show.bs.modal', ->
    changeSlide()

  $('.images-slider .slider-nav').on 'afterChange', ->
    changeSlide()

  $('.rest-places .slider').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    focusOnSelect: true,
  })

changeSlide = ->
  $('.slider-for').children().remove()
  $('.slider-nav .slick-current img').clone().appendTo('.slider-for')

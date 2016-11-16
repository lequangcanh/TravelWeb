$(document).on 'turbolinks:load', ->
  $('.rest-place .name').click (e)->
    e.preventDefault()
    $name = $(this)
    $modal = $('#rest-place-modal')
    link = $(this).find('a').attr('href')
    $.get(link).done (response)->
      $modal.find('.holder').empty()
      $name.prev().clone().prependTo($modal.find('.holder'))
      $modal.find('.modal-title').text(response.name + ' - ' +
                                       response.province.name)
      # $modal.find('.province').text(response.province.name)
      $modal.find('.details').text(response.details)
      $modal.find('.phone').text(response.phone)
      $modal.find('.website').text(response.website)
      $modal.modal('show')

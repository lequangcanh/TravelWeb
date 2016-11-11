$('.places.show').ready ->
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

$('.places.new').ready ->
  $('#photos').change ->
   # Get count of selected files
    countFiles = $(this)[0].files.length

    imgPath = $(this)[0].value
    extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase()
    if extn == 'png' || extn == 'jpg' || extn == 'jpeg'
      $image_holder = $('.image-holder')
      $image_holder.empty()
      if (typeof (FileReader) != 'undefined')
        # loop for each file selected for uploaded.
        for i in [0...countFiles] by 1
          reader = new FileReader()
          reader.onload = (e)->
            $wrapper = $('<div>', {class: 'image-wrapper'})
            $('<img />', {
              'src': e.target.result,
              'class': 'thumb-image'
            }).appendTo($wrapper)
            $wrapper.appendTo($image_holder)

          $image_holder.show()
          reader.readAsDataURL($(this)[0].files[i])
      else
        alert('This browser does not support FileReader.')
    else
      $image_holder.empty()
      alert('Please select only images.')

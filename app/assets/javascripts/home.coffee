$('.home.index').ready ->
  $('.place-images').slick({
    autoplay: true,
    arrows: false,
    dots: false
  })

  $('.recent-places').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
    arrows: true
  })

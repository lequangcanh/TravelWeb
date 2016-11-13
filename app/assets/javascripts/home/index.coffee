$('.home.index').ready ->
  $('.place-images').slick({
    autoplay: true,
    arrows: false,
    dots: false,
    fade: true,
    cssEase: 'linear'
  })

  $('.recent-places').slick({
    autoplay: true,
    autoplaySpeed: 4000,
    slidesToShow: 3,
    slidesToScroll: 1,
    arrows: true,
    dots: false
  })

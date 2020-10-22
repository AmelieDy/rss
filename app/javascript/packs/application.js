// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// $('.new_feed').on('click', function(){
//   // Pass values to controller to register datas
//   status_comment    = $(this).data('status');
//
//
//   $.ajax({
//     type: 'GET',
//     url: '<%= Rails.application.routes.url_helpers.comments_path(format: :js)%>',
//     data: { 'status': status_comment,
//             'subject': subject,
//             'user_from': user_from,
//             'user_to': user_to,
//             'order_by': order_by
//           },
//   });
// });

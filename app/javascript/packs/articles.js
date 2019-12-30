jQuery(document).ready(function() {
  $('#articles-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": {
      "url": $('#articles-datatable').data('source')
    },
    "pagingType": "full_numbers",
    "columns": [
      {"data": "title"},
      {"data": "description"},
      {"data": "categories"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
});
<script type="text/javascript" charset="utf-8">
  $(document).ready(function ()
                    {
                      $('table[id^="datatable"]').each(function (index)
                                                       {
                                                         $(this).tablecloth({
                                                                              theme: "stats",
                                                                              striped: true,
                                                                              sortable: true,
                                                                              condensed: false})
                                                       })
                    });
  $(document).ready(function ()
                    {
                      $('table[id^="infotable"]').each(function (index)
                                                       {
                                                         $(this).tablecloth({
                                                                              theme: "stats",
                                                                              striped: true,
                                                                              sortable: true,
                                                                              condensed: false})
                                                       })
                    });

</script>
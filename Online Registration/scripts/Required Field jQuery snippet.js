<script>
$j("form").submit(function(e) {

    var ref = $j(this).find("[required]");

    $j(ref).each(function() {
        if ( $j(this).val() == '' )
        {
            alert("Required field should not be blank.");

            $(this).focus();

            e.preventDefault();
            return false;
        }
    });  return true;
});
</script>
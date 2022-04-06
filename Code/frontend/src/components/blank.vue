<script>
export default {
  beforeRouteEnter (to, from, next) {
    next((xq) => {
      xq.$router.replace({
        path: '/home/:username',
        name: 'home',
        params: {
          username: xq.$route.params['username']
        }
      })
    })
  }
}
</script>

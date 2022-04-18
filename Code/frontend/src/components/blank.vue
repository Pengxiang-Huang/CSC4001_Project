<script>
export default {
  beforeRouteEnter (to, from, next) {
    next((xq) => {
      if (from.name === 'home') {
        xq.$router.replace({
          path: '/home/:username',
          name: 'home',
          params: {
            username: xq.$route.params['username']
          }
        })
      }
      if (from.name === 'blog') {
        xq.$router.replace({
          path: '/blog',
          query: {
            question_id: xq.$route.query.question_id,
            username: xq.$route.query.username,
            searchCondition: xq.$route.query.searchCondition,
            searchContent: xq.$route.query.searchContent,
            inSearch: xq.$route.query.inSearch
          }
        })
      }
    })
  }
}
</script>

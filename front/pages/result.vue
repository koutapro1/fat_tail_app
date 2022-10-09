<template>
  <v-app>
    <v-main>
      <div v-for="result in results" class="d-flex">
        <div v-if="result.visual.length > 0" class="visual">
          <span v-for="visual in result.visual">
            {{visual}}
          </span>
        </div>
        <div v-else class="visual">
          <span>
            Normal
          </span>
        </div>
        <div v-if="result.het.length > 0" class="het pl-2 pr-5">
          <span v-for="het in result.het">
            het {{het}}
          </span>
        </div>
        <div class="possibility">
          {{result.possibility}}%
        </div>
      </div>

    </v-main>
  </v-app>
</template>

<script>
  import axios from "~/plugins/axios"
  import { mapGetters } from 'vuex'

  export default {
    layout: 'plain',
    data() {
      return {
        male_visual: this.$route.query.male_visual,
        male_het: this.$route.query.male_het,
        female_visual: this.$route.query.female_visual,
        female_het: this.$route.query.female_het,
        results: []
      }
    },
    computed: {
      ...mapGetters(["morphs"])
    },
    created() {
      this.searchResult();
    },
    methods: {
      searchResult() {
        axios.get("/morphs/calculate",
        {
          params: {
            male_visual: this.male_visual,
            male_het: this.male_het,
            female_visual: this.female_visual,
            female_het: this.female_het
          }
        }).then(res => {
          if (res.data) {
            this.results = res.data
          }
        })
      },
    }
  }
</script>
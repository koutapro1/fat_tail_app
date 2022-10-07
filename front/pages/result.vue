<template>
  <v-app>
    <v-main>
      <ul>
        <li
          v-for="result in results"
        >
          {{result.visual}} het{{result.het}}
        </li>
      </ul>
    </v-main>
  </v-app>
</template>

<script>
  import axios from "~/plugins/axios"

  export default {
    layout: 'plain',
    data() {
      return {
        morphs: [],
        selected_male_visual: this.$route.query.male_visual,
        selected_male_het: this.$route.query.male_het,
        selected_female_visual: this.$route.query.female_visual,
        selected_female_het: this.$route.query.female_het,
        results: []
      }
    },
    created() {
      this.searchResult();
    },
    methods: {
      searchResult() {
        axios.get("/morphs/calculate",
        {
          params: {
            male_visual: this.selected_male_visual,
            male_het: this.selected_male_het,
            female_visual: this.selected_female_visual,
            female_het: this.selected_female_het
          }
        }).then(res => {
          if (res.data) {
            this.results = res.data
            console.log(res.data)
          }
        })
      },
    }
  }
</script>
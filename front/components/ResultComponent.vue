<template>
  <div class="result-area">
    <v-row justify="space-around" align-content="center">
      <v-col cols="8">
        <v-data-table :headers="headers" :items="results" disable-pagination hide-default-footer class="overflow-y-auto result-table">
          <template v-slot:body="{ items }">
            <tbody class="custom-body">
              <tr v-for="result in results" :key="result.id" class="custom-tr">
                <td><p v-for="visual in result.visual">{{visual}}</p></td>
                <td><p v-for="het in result.het">{{het}}</p></td>
                <td>{{result.possibility}}%</td>
              </tr>
            </tbody>
          </template>
        </v-data-table>
      </v-col>
    </v-row>
    <v-btn @click="backToCalculator">←Back</v-btn>
  </div>
</template>

<script>
  export default {
    props: [
      'results'
    ],
    data() {
      return {
        headers: [
          { text: 'visual', value: 'visual' },
          { text: 'het', value: 'het' },
          { text: 'possibility', value: 'possibility' }
        ]
      }
    },
    methods: {
      backToCalculator() {
        this.$emit('back-to-calculator')
      }
    }
  }
</script>
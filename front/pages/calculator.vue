<template>
  <v-app>
    <v-main>
      <v-container fluid class="main-container">
        <top-images-component />
        <div class="explanation">
          <p>
            All you need to do now is choose the genetics of your pairing below.<br>
            While we have worked incredibly hard to make this genetic calculator as accurate as possible<br>
            (with some new features that other calculators do not have),<br>
            it should be used as a guide and should not be used as a 100% guarantee of your babies<br>
            (as you may have HETs that you are not aware of and haven't added them to the calculation).
          </p>
        </div>
        <transition name="fade" mode="out-in">
          <CalculatorComponent
            v-if="isVisibleCalculator"
            key="calculator"
            :selected_morphs="selected_morphs"
            :morphs="morphs"
            @search-result="searchResult"
            @set-selected-morphs="setSelectedMorphs"
          />
          <ResultComponent
            key="result"
            v-if="isVisibleResult"
            :results="results"
            @back-to-calculator="handleShowCalculator"
          />
        </transition>
      </v-container>
    </v-main>
  </v-app>
</template>

<style>
  .main-container
  {
    position: relative;
    padding: 0;
    height: 100%;
  }
  /* 背景画像 -------- */
  .top-images
  {
    min-height: 11rem;
  }
  .left-leaf
  {
    position: absolute;
    top: -300px;
    left: -300px;
    z-index: 5;
  }
  .right-leaf
  {
    position: absolute;
    top: -300px;
    right: -300px;
    z-index: 5;
  }
  .title
  {
    position: relative;
    top: -300px;
    z-index: 10;
  }
  .title img
  {
    display: block;
    margin: auto;
  }
  .left-shadow
  {
    position: absolute;
    bottom: 0;
    left: 0;
  }
  .right-shadow
  {
    position: absolute;
    bottom: 0;
    right: 0;
  }
  .explanation
  {
    text-align: center;
    font-size: 0.8rem;
    font-weight: bold;
    line-height: 1;
  }
  /* モルフ入力エリア -------- */
  .search-form
  {
    position: relative;
    min-width: 70vw;
    max-height: 19rem;
  }
  .search-form h2
  {
    width: fit-content;
    margin: auto;
    color: rgb(254,255,255);
    border-bottom: solid 5px rgb(231,219,207);
    text-shadow: 4px 4px 4px rgb(113,87,64);
    font-size: 2rem;
    line-height: 1.2;
  }
  .select-area
  {
    width: 90%;
    margin: auto;
  }
  .male-search-form, .female-search-form
  {
    position: relative;
    background-color: rgb(179,135,88);
    border: solid 5px rgb(255,255,250);
    border-radius: 5rem;
    z-index: 10;
  }
  .male-select-container, .female-select-container
  {
    padding: 2rem;
  }
  .gecko-image-left
  {
    height: 7rem;
    position: absolute;
    transform: scale(-1, 1) rotate(-15deg);
    bottom: -3rem;
    left: -3rem;
  }
  .gecko-image-right
  {
    height: 7rem;
    position: absolute;
    top: -1.7rem;
    right: -3rem;
  }
  .submit-area
  {
    position: relative;
    top: -5rem;
    height: 0;
    z-index: 20;
    pointer-events: none;
  }
  .egg-image
  {
    display: block;
    margin: auto;
  }
  .ok-button
  {
    position: relative;
    top: -5rem;
    display: block;
    margin: auto;
    background-color: rgb(199,120,90);
    color: rgb(248,255,255);
    border: solid 8px rgb(248,255,255);
    border-radius: 10px;
    font-size: 3rem;
    font-weight: bold;
    text-shadow: 4px 4px 4px rgb(113,87,64);
    width: 10rem;
    height: 5rem;
    box-shadow: 2px 4px 8px rgba(0, 0, 0, 0.7);
    pointer-events: auto;
    transition: .3s;
  }
  .ok-button:hover
  {
    transform: scale(1.1);
  }
  .ok-button:active
  {
    transform: translate(0,2px);
    box-shadow: 2px 1px 8px rgba(0, 0, 0, 0.7);
  }
  /* 結果ページ -------- */
  .result-area {
    position: relative;
    max-height: 28rem;
  }
  .v-data-table {
    max-height: 28rem;
    position: relative;
    z-index: 10;
  }
  .v-data-table th,td {
    background-color: rgb(179,135,88);
    color: rgb(248,255,255);
    border: solid 4px rgb(255,255,250);
    border-radius: 5px;
  }

  .theme--light.v-application
  {
    background-color: #FFF7D2;
  }
  .theme--light.v-label
  {
    color: white !important;
  }
  .theme--light.mdi-menu-down
  {
    color: white !important;
  }
  .theme--light.v-text-field > .v-input__control > .v-input__slot:before
  {
    border-color: white;
  }
  .theme--light.v-text-field:not(.v-input--has-state):hover > .v-input__control > .v-input__slot:before
  {
    border-color: white;
  }
  .theme--light.v-text-field > .v-input__control > .v-input__slot:after
  {
    border-color: white;
  }
  .theme--light.v-text-field:not(.v-input--has-state):hover > .v-input__control > .v-input__slot:after
  {
    border-color: white;
  }
  .theme--light.v-chip:not(.v-chip--active)
  {
    background: white;
  }
  input
  {
    color: white;
  }

  .fade-enter-active, .fade-leave-active {
    transition: opacity 1s;
  }
  .fade-enter, .fade-leave-to {
    opacity: 0;
  }

</style>

<script>
  import { mapGetters, mapActions } from 'vuex'
  import axios from "~/plugins/axios"
  import anime from 'animejs'

  export default {
    layout: 'plain',
    data() {
      return {
        selected_morphs: {
          male_visual: [],
          male_het: [],
          female_visual: [],
          female_het: [],
        },
        results: [],
        isVisibleCalculator: true,
        isVisibleResult: false,
      }
    },
    computed: {
      ...mapGetters(["morphs"])
    },
    created() {
      this.fetchMorphs();
    },
    mounted() {
      this.setAnimation();
    },
    methods: {
      ...mapActions(["fetchMorphs"]),
      setSelectedMorphs(newVal) {
        this.selected_morphs = newVal;
      },
      handleShowResult() {
        this.isVisibleResult = true;
        this.isVisibleCalculator = false;
      },
      handleShowCalculator() {
        this.isVisibleResult = false;
        this.isVisibleCalculator = true;
      },
      searchResult() {
        axios.get("/morphs/calculate",
        {
          params: {
            male_visual: this.selected_morphs.male_visual,
            male_het: this.selected_morphs.male_het,
            female_visual: this.selected_morphs.female_visual,
            female_het: this.selected_morphs.female_het
          }
        }).then(res => {
          if (res.data) {
            for (let i = 0; i < res.data.length; i ++) {
              res.data[i].visual = res.data[i].visual.join(', ')
              res.data[i].het = res.data[i].het.join(', ')
            }
            this.results = res.data
          }
        });
        this.handleShowResult();
      },
      setAnimation() {
        const animation = anime.timeline({});
        const xMax = 16;

        animation
        .add({
          targets: '.left-leaf',
          translateX: 300,
          translateY: 300,
          duration: 500,
          easing: 'easeInOutBack'
        })
        .add({
          targets: '.right-leaf',
          translateX: -300,
          translateY: 300,
          duration: 500,
          easing: 'easeInOutBack'
        }, '-=350')
        .add({
          targets: ['.left-shadow', '.right-shadow'],
          easing: 'easeInOutSine',
          duration: 600,
          opacity: [0, 1]
        }, 100)
        .add({
          targets: '.search-form',
          easing: 'easeInOutSine',
          duration: 600,
          opacity: [0, 1]
        }, 100)
        .add({
          targets: '.title',
          translateY: 300,
          duration: 1000,
          easing: 'easeOutBounce'
        })
        .add({
          targets: '.egg-image',
          easing: 'easeInOutSine',
          duration: 550,
          scale: [1.4, 1, 1],
          translateX: [
            {
              value: xMax * -1,
            },
            {
              value: xMax,
            },
            {
              value: xMax/-2,
            },
            {
              value: xMax/2,
            },
            {
              value: 0
            }
          ],
        })
      }
    }
  }
</script>
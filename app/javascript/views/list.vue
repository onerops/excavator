<template>
  <div>
    <b-container class="bv-example-row">
      <b-row>
         <b-col>
            <b-breadcrumb :items="breadcrumbs"></b-breadcrumb>
        </b-col>
      </b-row>
    </b-container>

    <b-container class="bv-example-row">
      <b-row>
        <b-col cols="12">
          <b-pagination
            v-model="page"
            :total-rows="total"
            :per-page="perPage"
            aria-controls="my-table"
          ></b-pagination>
          <b-table id="my-table" striped hover :items="items" :per-page="perPage" >
            <template v-slot:cell(id)="data">
              <router-link :to="{name:'item',params:{id:data.value}}" >{{ data.value }}</router-link>
            </template>
          </b-table>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
  export default {
    data(){
      return {
        perPage: 10,
        breadcrumbs: [
          {
            text: 'Main',
            href: '#/'
          },
          {
            text: 'List',
            active: true
          },
          {
            text: 'Item',
            active: true
          }
        ]
      }
    },
    computed:{
      items(){
        return this.$store.getters["getItems"]
      },
      page:{
        get(){
          return this.$store.getters["getPage"]
        },
        set(val){
          this.$store.dispatch("SetPage", val)
        }
        
      },
      total(){
        return this.$store.getters["getTotal"]
      }
    },
    created(){
      this.perPage = this.$store.getters["getPerPage"]
      this.load()
    },
    methods:{
      load(){
        this.$store.dispatch("List")
      }
    },
    watch:{
      page(newVal){
        this.load()
      }
    }
  }
</script>



      
      
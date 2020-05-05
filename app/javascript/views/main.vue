<template>
    <b-container class="bv-example-row" fill-height fluid>
      <b-row align="center"
      justify="center">
        <b-col>
            <a href="/api-docs" class="btn btn-danger">Explore API</a>
            <b-button variant="primary" @click="$router.push({name:'list'})">Eplore Front</b-button>
        </b-col>
      </b-row>
    </b-container>
</template>

<script>
export default {}
</script>


<script setup>
// includes
import { usePage, Link } from "@inertiajs/vue3";
import { ref } from "vue";
import Footer from "./includes/Footer.vue";
import NavBar from "./includes/NavBar.vue";
import SideBar from "./includes/SideBar.vue";
import { useApp } from "@/composables/useApp";
import { onMounted } from "vue";
import { useAppOptionStore } from '@/stores/app-option';
const appOption = useAppOptionStore();
const { props } = usePage();
var url_assets = "";
var url_principal = "";
const { loading, setLoading } = useApp();
setLoading(true);

onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);

    url_assets = props.url_assets;
    url_principal = props.url_principal;
});
</script>
<template>
    <!-- BEGIN #loader -->
	<!-- <div id="loader" class="app-loader"> -->
		<!-- <span class="spinner"></span> -->
	<!-- </div> -->
	<!-- END #loader -->
	<!-- BEGIN #app -->
	<div class="app app-header-fixed app-sidebar-fixed" :class="{
		'app-sidebar-minified':appOption.appSidebarMinified
	}">
		<!-- BEGIN #header -->
		<div id="header" class="app-header" data-bs-theme="dark">
			<!-- BEGIN navbar-header -->
			<div class="navbar-header">
				<a href="index.html" class="navbar-brand"><i class="fab fa-facebook-square fa-lg"></i> <b>Color</b> Admin <small>social</small></a>
				<button type="button" class="navbar-mobile-toggler" data-toggle="app-sidebar-mobile">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div>
			<!-- END navbar-header -->
			<!-- BEGIN header-nav -->
			<div class="navbar-nav">
				<NavBar></NavBar>
			</div>
			<!-- END header-nav -->
		</div>
		<!-- END #header -->
	
		<!-- BEGIN #sidebar -->
		<div id="sidebar" class="app-sidebar">
			<!-- BEGIN scrollbar -->
			<div class="app-sidebar-content" data-scrollbar="true" data-height="100%">
				<SideBar></SideBar>
			</div>
			<!-- END scrollbar -->
		</div>
		<div class="app-sidebar-bg"></div>
		<div class="app-sidebar-mobile-backdrop"><a href="#" data-dismiss="app-sidebar-mobile" class="stretched-link"></a></div>
		<!-- END #sidebar -->
		
		<!-- BEGIN #content -->
		<div id="content" class="app-content">
            <slot></slot>
		</div>
		<!-- END #content -->
	</div>
	<!-- END #app -->
</template>

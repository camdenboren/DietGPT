<!-- SPDX-FileCopyrightText: 2025 Camden Boren -->
<!-- SPDX-License-Identifier: GPL-3.0-or-later -->

<script setup lang="ts">
import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarRail,
} from "./ui/sidebar";

const data = {
  navMain: [
    {
      title: "Tools",
      url: "#",
      items: [
        { title: "Meal Planning", url: "#/" },
        { title: "Calorie Counting", url: "#/calorie-counting" },
      ],
    },
    {
      title: "Info",
      url: "#",
      items: [
        { title: "Usage", url: "#/usage" },
        { title: "Project", url: "#/project" },
      ],
    },
  ],
};
</script>

<template>
  <Sidebar>
    <SidebarHeader>
      <SidebarMenu>
        <SidebarMenuItem>
          <span class="font-semibold">DietGPT</span>
        </SidebarMenuItem>
      </SidebarMenu>
    </SidebarHeader>
    <SidebarContent>
      <SidebarGroup v-for="item in data.navMain" :key="item.title">
        <SidebarGroupLabel>{{ item.title }}</SidebarGroupLabel>
        <SidebarGroupContent>
          <SidebarMenu>
            <SidebarMenuItem v-for="subItem in item.items" :key="subItem.title">
              <SidebarMenuButton as-child>
                <a :href="subItem.url">{{ subItem.title }}</a>
              </SidebarMenuButton>
            </SidebarMenuItem>
          </SidebarMenu>
        </SidebarGroupContent>
      </SidebarGroup>
    </SidebarContent>
    <SidebarRail />
  </Sidebar>
</template>

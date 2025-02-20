<!-- SPDX-FileCopyrightText: 2025 Camden Boren -->
<!-- SPDX-License-Identifier: GPL-3.0-or-later -->

<script setup lang="ts">
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
} from "./ui/breadcrumb";
import { Separator } from "./ui/separator";
import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarInset,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarProvider,
  SidebarRail,
  SidebarTrigger,
} from "./ui/sidebar";

const data = {
  navMain: [
    {
      title: "Tools",
      url: "#",
      items: [
        { title: "Meal Planning", url: "#/meal-planning" },
        { title: "Calorie Counting", url: "#/calorie-counting" },
      ],
    },
    {
      title: "Info",
      url: "#",
      items: [
        { title: "Usage", url: "#/" },
        { title: "Project", url: "#/project" },
      ],
    },
  ],
};
</script>

<template>
  <SidebarProvider>
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
              <SidebarMenuItem
                v-for="subItem in item.items"
                :key="subItem.title"
              >
                <SidebarMenuButton
                  :class="{ 'is-active': subItem.isActive }"
                  as-child
                >
                  <a :href="subItem.url">{{ subItem.title }}</a>
                </SidebarMenuButton>
              </SidebarMenuItem>
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>

      <SidebarRail />
    </Sidebar>

    <SidebarInset>
      <header class="flex h-16 shrink-0 items-center gap-2 border-b px-4">
        <SidebarTrigger class="-ml-1" />
        <Separator orientation="vertical" class="mr-2 h-4" />
        <Breadcrumb>
          <BreadcrumbList>
            <BreadcrumbItem class="hidden md:block">
              <BreadcrumbLink href="#"> Calorie Counting </BreadcrumbLink>
            </BreadcrumbItem>
          </BreadcrumbList>
        </Breadcrumb>
      </header>
    </SidebarInset>
  </SidebarProvider>
</template>

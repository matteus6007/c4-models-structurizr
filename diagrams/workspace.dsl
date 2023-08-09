workspace {
    model {
        customer = person "Customer"

        group "E-Commerce Platform" {
            platform = softwareSystem "E-commerce Platform" "Allows customers to search view and purchase products" {
                webApp = container "Web Application" "Web frontend for buying a product" "React/Nx" {
                    landingApp = component "Homepage" "Landing microsite" "React/Nx"
                    searchApp = component "Search" "Search microsite" "React/Nx"
                    productApp = component "Product Details" "Product Details microsite" "React/Nx"
                    orderApp = component "Orders" "Orders microsite" "React/Nx"

                    customer -> landingApp "Visits /" "HTTPS"
                    customer -> searchApp "Visits /search" "HTTPS"
                    customer -> productApp "Visits /products/{id}" "HTTPS"
                    customer -> orderApp "Visits /orders/{id}" "HTTPS"
                }

                api = container "API" "API Gateway that manages products" "API Gateway" {
                    searchApi = component "Search API" "API that provides product filtering" "API Gateway"
                    productApi = component "Product API" "API that manages product details" "API Gateway"
                    orderApi = component "Orders API" "API that manages customer orders" "API Gateway"
                }

                db = container "Database" "Tables to store product and customer data" "DynamoDB" {
                    tags "Database"
                }

                searchApp -> searchApi "Makes calls to" "JSON/HTTPS"
                productApp -> productApi "Makes calls to" "JSON/HTTPS"
                orderApp -> orderApi "Makes calls to" "JSON/HTTPS"
                api -> db "Reads and writes to" "JSON/HTTPS"
            }
        }

        dwh = softwareSystem "Data Warehouse" "Reporting and data insights"
        emailPlatform = softwareSystem "Email Platform" "Email marketing platform" {
            tags "External"
        }
        cdp = softwareSystem "Customer Data Platform (CDP)" "Customer profiling" {
            tags "External"
        }
        cms = softwareSystem "CMS" "Content Management System" {
            tags "External"
        }
       
        platform -> dwh "Domain events" "EventBridge"
        platform -> cdp "Send customer interaction and domain events to" "HTTPS"
        cdp -> emailPlatform "Send email using" "HTTPS"
        emailPlatform -> customer "Sends email to" "SMTP"
        landingApp -> cms "Makes calls to" "HTTPS"
    }

    views {
        systemContext platform "Ecommerce-Platform-Context" {
            include * emailPlatform
            autolayout lr
        }

        container platform "Ecommerce-Platform-Container" {
            include *
            autolayout lr            
        }

        component webApp "Web-Application-Component" {
            include *
            autolayout lr            
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Component" {
                background #85bbf0
                color #ffffff
            }                        
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            element "External" {
                background #999999
                color #ffffff
            }
            element "Database" {
                shape cylinder
            }                       
        }        
    }     
}
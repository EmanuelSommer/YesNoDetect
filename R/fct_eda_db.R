#' Plot the proportions of labels in the database as a barplot
#'
#' @param data data from the database (tibble/dataframe with column 'label')
#'
#' @return ggplot2 object
#' @export
#' @import dplyr
#' @import ggplot2
#'
#' @author Emanuel Sommer
plot_label_dist <- function(data) {
  len_full <- length(data$label)
  data %>%
    group_by(label) %>%
    summarise(percentage = n()/len_full) %>%
    ggplot(aes(x = 1, y = percentage, fill = relevel(factor(label),"x"))) +
    geom_col() +
    geom_hline(yintercept = 0.5,linetype = "longdash",color = "white",size = 1.2)+
    annotate(geom = "text",label = "No",color = "white",x = 1,y = 0.9,size = 12)+
    annotate(geom = "text",label = "Yes",color = "white",x = 1,y = 0.1,size = 12)+
    scale_x_discrete(labels = c("No","Yes"))+
    scale_fill_manual(labels = c("No","Yes"),values = c("#B50945","#409932"))+
    ylim(0,1)+
    labs(x = "",title = "Propotion of labels in the database",y = "",
         subtitle = "Optimum: 0.5", fill = "label:")+
    coord_flip()+
    theme_classic()+
    theme(legend.position = "none",
          panel.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"),
          panel.border = element_rect(color = "#1AA7ED",fill = NA),
          plot.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"),
          legend.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"),
          legend.box.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"))
}


#' Plot the average handdrawn boxes
#'
#' @param df data from the database (tibble/dataframe with column 'label')
#' @param sel_label character label either x or y
#'
#' @return ggplot2 object
#' @export
#' @import dplyr
#' @import ggplot2
#'
#' @author Emanuel Sommmer
plot_average_box <- function(df,sel_label = c("x","y")){
  if(sel_label == "x"){
    heading <- "The average no"
  } else {
    heading <- "The average yes"
  }
  mean_vec <- df %>%
    filter(label == sel_label) %>%
    select(-label) %>%
    as.matrix() %>%
    colMeans()
  data.frame(value = mean_vec,
             y = rep(28:1,each = 28),
             x = rep(1:28,28)) %>%
    ggplot(aes(x = x, y = y, fill = value))+
    geom_tile()+
    scale_fill_gradient(low = "white",high = "black")+
    labs(x = "",y = "",title = heading)+
    theme_minimal()+
    theme(legend.position = "none",
          aspect.ratio = 1,
          axis.text = element_blank(),
          panel.grid = element_blank(),
          panel.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"),
          panel.border = element_rect(color = "#1AA7ED",fill = NA),
          plot.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"),
          legend.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"),
          legend.box.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"))
}



  
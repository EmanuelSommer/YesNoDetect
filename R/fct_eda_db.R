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
    ggplot(aes(x = 1, y = percentage, fill = label)) +
    geom_col() +
    geom_hline(yintercept = 0.5,linetype = "longdash",color = "white",size = 1.2)+
    scale_x_discrete(labels = c("No","Yes"))+
    scale_fill_manual(labels = c("No","Yes"),values = c("#B50945","#409932"))+
    ylim(0,1)+
    labs(x = "",title = "Propotion of labels in the database",y = "",
         subtitle = "Optimum: 0.5", fill = "label:")+
    coord_flip()+
    theme_classic()+
    theme(legend.position = "bottom",
          panel.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"),
          panel.border = element_rect(color = "#1AA7ED",fill = NA),
          plot.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"),
          legend.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"),
          legend.box.background = element_rect(fill = "#1AA7ED", color = "#1AA7ED"))
}

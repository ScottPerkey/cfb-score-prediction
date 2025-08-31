start_time<-Sys.time()
#install.packages("tidyverse", repos="https://cloud.r-project.org")
library(tidyverse)

extract_all<-function(csv_files,ptscol,oppcol){
	total_list_pts<-list()
	total_list_opps<-list()
	for (files in csv_files){
		data<-read_csv(files)
		ptsC<-data[[ptscol]]
		oppC<-data[[oppcol]]
		total_list_pts<-c(total_list_pts,list(ptsC))
		total_list_opps<-c(total_list_opps,list(oppC))

	}

	result<-list(pts_for_list= total_list_pts,opps_for_list=total_list_opps)
	return(result)
}

main<-function(){
	
	main_process<-c("appalachian-state2020.csv","texas-state2020.csv")
	directory_path<-"/home/perkeys/stolen_credit_cards/cfb_scores_arch/cfb_2020/"
	vs_name_list<-list()
	for (vs_name in main_process){
		vs_name_list<-c(vs_name_list,list(paste0(directory_path,vs_name)))
	}

	pts_for_col<-"Pts"
	pts_opps_col<-"Opp"
	main_vs<-extract_all(vs_name_list,pts_for_col,pts_opps_col)
	
	for1<-main_vs$pts_for_list[[1]]
	for2<-main_vs$pts_for_list[[2]]
	opp1<-main_vs$opps_for_list[[1]]
	opp2<-main_vs$opps_for_list[[2]]
	
	for_meant1<-mean(for1)
	for_meant2<-mean(for2)
	opp_meant1<-mean(opp1)
	opp_meant2<-mean(opp2)

	name_list=c("charlotte2020.csv","marshall2020.csv","arkansas-state2020.csv","louisiana-monroe2020.csv")
	total_name_list<-list()
	for (name in name_list){
		total_name_list<-c(total_name_list,list(paste0(directory_path,name)))
	}
	secondary<-extract_all(total_name_list,pts_for_col,pts_opps_col)
	pts_list_all<-(secondary$pts_for_list)
	opps_list_all<-(secondary$opps_for_list)

	pts_mean_opps<-list()
	for (pts in pts_list_all){
		pts_mean_opps<-c(pts_mean_opps,list(mean(pts)))

	}
	pts_moppflat<-unlist(pts_mean_opps)

	opps_mean_opps<-list()
	for (opps in opps_list_all){
		opps_mean_opps<-c(opps_mean_opps,list(mean(opps)))
	}
	opps_moppflat<-unlist(opps_mean_opps)

	name_list2=c("southern-methodist2020.csv","texas-san-antonio2020.csv","louisiana-monroe2020.csv","boston-college2020.csv","troy2020.csv","south-alabama2020.csv","brigham-young2020.csv","louisiana-lafayette2020.csv")
	total_name_list2=list()
	for (name in name_list2){
		total_name_list2<-c(total_name_list2,list(paste0(directory_path,name)))
	}
	secondary2<-extract_all(total_name_list2,pts_for_col,pts_opps_col)
	pts_list_all2<-(secondary2$pts_for_list)
	opps_list_all2<-(secondary2$opps_for_list)

	pts_mean_opps2<-list()
	for (pts in pts_list_all2){
		pts_mean_opps2<-c(pts_mean_opps2,list(mean(pts)))

	}
	pts_moppflat2<-unlist(pts_mean_opps2)
	opps_mean_opps2<-list()
	for (opps in opps_list_all2){
		opps_mean_opps2<-c(opps_mean_opps2,list(mean(opps)))
	}
	opps_moppflat2<-unlist(opps_mean_opps2)

	offo1<-for_meant1/mean(opps_moppflat)
	dffo1<-mean(pts_moppflat)/opp_meant1
	offo2<-for_meant2/mean(opps_moppflat2)
	dffo2<-mean(pts_moppflat2)/opp_meant2

	f1<-opp_meant2*offo1	
	f2<-for_meant1/dffo2

	score_t1<-(f1+f2)/2
	
	f3<-opp_meant1*offo2
	f4<-for_meant2/dffo1
	score_t2<-(f3+f3)/2
	cat("App State: ", score_t1,"\n")
	cat("Texas State: ", score_t2,"\n")

}

main()

#WHAT DO WE WANT TO DO:
# DOWNLOAD ALL OF THE CSV'S (OR JUST COPY PASTE WHO CARES)
# NOW THAT WE HAVE ALL OF THE CSV'S THAT WE WANT, LETS LOAD ALL OF THEM UP?
# LIKE READ CSV, THEN PUT THEM IN ARRAYS
# THEN WE DO THE MATH AND COMPARE THEM

end_time<-Sys.time()
execution_time<-as.numeric(difftime(end_time,start_time,units="sec"))
cat("It took ", execution_time, "second to run.\n")


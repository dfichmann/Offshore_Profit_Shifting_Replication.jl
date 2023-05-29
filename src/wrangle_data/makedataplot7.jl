function makedataforplot7()
    public.gdibusn = public.gdin - (public.gdpn .- public.gvabusn)
    public.gdibusr = public.gdibusn ./ public.gva_deflator
    
    prod = DataFrame(Year = public.year)
    prod.uprod_log = log.((public.gvabusr .* public.gdibusr).^(1/2) ./ public.hrs)
    
    prod.uprod_gr = [missing;diff(prod.uprod_log) .* 100]
    prod.uprod_cum = (prod.uprod_log .- prod.uprod_log[1]) .* 100
    
    prod.gvabusr_adj = (public.gvabusn .- adj_agg.adjearn3s_cca) ./ public.gva_deflator
    prod.gdibusr_adj = (public.gdibusn .- adj_agg.adjearn3s_cca) ./ public.gva_deflator
    prod.aprod_log = log.((prod.gvabusr_adj .* prod.gdibusr_adj).^(1/2) ./ public.hrs)
    prod.aprod_gr = [missing; diff(prod.aprod_log) .* 100]
    prod.aprod_cum = (prod.aprod_log .- prod.aprod_log[1]) .* 100

    return prod
end
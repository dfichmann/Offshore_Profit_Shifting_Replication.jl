### REPLICATION CODE FOR OFFSHORE PROFIT SHIFTING PAPER ###
    #  DOI: 10.1257/aer.20190285

# Figures and tables I
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
import seaborn as sea
from matplotlib.lines import Line2D
import numpy as np

# I take so long to write papers, MPL changed their default style.
plt.style.use('classic')
mpl.rc('lines', linewidth=2.5)

def get_kim_fig():
    fig, ax = plt.subplots()
    sea.despine()
    
    ax.tick_params(axis='both', labelsize=14)
    
    ax.grid(linestyle=':')
    
    # mpl will try to set an offset if you are using large nunbers
    ax.get_xaxis().get_major_formatter().set_useOffset(False)
    
    ax.xaxis.set_ticks_position('bottom')
    ax.yaxis.set_ticks_position('left')

    return fig, ax

import pandas as pd

def add_after(text, beginswith, toinsert):
    '''Adds a row to a latex table. 
    Inserts the string `toinsert` into the table string `text` 
    after the row that begins with `beginswith`.'''
    ss = text.splitlines()
    
    ii = '0'
    for i, l in enumerate(ss):
        if l.startswith(beginswith) == True:
            ii = i
            break
    
    # This will throw an error if beginswith is not found.
    ss.insert(ii+1, toinsert)
    return '\n'.join(ss)

### Load the aggregate data
public = pd.read_csv('../3-intermediate-files/aggregate.csv', index_col=0)
public.head(1)

### Load the adjustments
adj_agg = pd.read_excel('../0-confidential-data-replication-files/USDIA/OutputAdjNet.xlsx', index_col='Year')
adj_agg = adj_agg.reindex(range(1982,2017))
adj_agg = adj_agg.interpolate()
adj_agg['adjearn3s_cca'] = adj_agg['adjwt3s']*public['income_adj_factor']
adj_agg['adjearncomps_cca'] = adj_agg['adjcomps']*public['income_adj_factor']
adj_agg['adjearnppes_cca'] = adj_agg['adjppes']*public['income_adj_factor']
adj_agg['adjearnrdstks_cca'] = adj_agg['adjrdstks']*public['income_adj_factor']
adj_agg.head(1)

### Load adjustments by industry
adj_ind = pd.read_excel('../0-confidential-data-replication-files/USDIA/OutputAdjNetIndustry.xlsx')
adj_ind = adj_ind.set_index(['Year', 'IEDindPar'])
adj_ind = adj_ind.unstack()
adj_ind = adj_ind.reindex(range(1982,2017)).interpolate()
adj_ind.head(1)

## Load adjustments by tax haven status
adj_tax = pd.read_excel('../0-confidential-data-replication-files/USDIA/OutputAdjNetHaven.xlsx', index_col=[0,1])
adj_tax = adj_tax.unstack()
adj_tax = adj_tax.reindex(range(1982,2017)).interpolate()
adj_tax.head(1)

## Figure 1A
fig, ax = get_kim_fig()

ax.plot(public.index, 100*public['usdiaincn']/public['gvabusn'], color='black')
ax.plot(public.index, -100*adj_agg['adjearn3s_cca']/public['gvabusn'], color='blue', label='Weighted')

ax.set_xlim(1981, 2017)
ax.set_ylim(0, 4.0)

ax.text(2002.5, 3.75, 'USDIA Income')
ax.text(2008, 1.8, 'Weighted\nAdjustment')
ax.set_ylabel('share of business-sector value added (percent)')

fig.savefig('../4-figures/agg_adj_share.pdf', bbox_inches='tight')

## Figure 1B
fig, ax = get_kim_fig()

ax.plot(public.index, public['usdiaincn']/public['gva_deflator'], color='black')
ax.plot(public.index, -1*adj_agg['adjearn3s_cca']/public['gva_deflator'], color='blue', label='Weighted')

ax.set_xlim(1981, 2017)
ax.set_ylim(0, 475)

ax.text(2002.2, 430, 'USDIA Income')
ax.text(2008, 210, 'Weighted\nAdjustment')
ax.set_ylabel('billions of dollars')

fig.savefig('../4-figures/agg_adj_l.pdf', bbox_inches='tight')

## Figure 2A
fig, ax = get_kim_fig()

ax.plot(public.index, public['usdiaincn']/public['gva_deflator'], color='black')

ax.plot(public.index, -1*adj_agg['adjearn3s_cca']/public['gva_deflator'], 
        color='blue', label='Weighted')
ax.plot(public.index, -1*adj_agg['adjearncomps_cca']/public['gva_deflator'], 
        color='red', linestyle = '--', label='Compensation')
ax.plot(public.index, -1*adj_agg['adjearnppes_cca']/public['gva_deflator'], 
        color='black', marker = 'X', label='PPE')
ax.plot(public.index, -1*adj_agg['adjearnrdstks_cca']/public['gva_deflator'], 
        color='green', marker = 'o', markeredgecolor = 'green', label='R&D')

ax.set_xlim(1981, 2017)
ax.set_ylim(0, 475)

ax.text(2002.2, 430, 'USDIA Income')
ax.set_ylabel('billions of dollars')
ax.legend(frameon=False, loc='upper left')

fig.savefig('../4-figures/agg_adj_weights.pdf', bbox_inches='tight')

## Figure 2B
boot = pd.read_excel('../0-confidential-data-replication-files/USDIA/OutputAggStdError.xlsx', index_col=[0,1]).unstack()
boot.columns = boot.columns.droplevel()
boot = boot.reindex(range(1982,2017))
boot = boot.interpolate()

# Deflate
for c in boot.columns:
    boot[c] = boot[c]/public['gva_deflator']*-1
    
# Define some quantile functions for the groupby application.
def q25(x):
    return x.quantile(0.25)

def q75(x):
    return x.quantile(0.75)

# This computes statistics across panels for each year.
boot = boot.reset_index()
boot = boot.melt(id_vars='Year')

boot = boot[['Year', 'value']].groupby('Year').agg([np.mean, np.std, q25, q75]).droplevel(0, axis=1)

boot.head(1)


fig, ax = get_kim_fig()

ax.plot(public.index, public['usdiaincn']/public['gva_deflator'], color='black')

ax.fill_between(boot.index, boot['mean']+boot['std']*2, boot['mean']-boot['std']*2, 
                facecolor='grey', alpha = 0.2, label='+/-2 s.d.')

ax.plot(public.index, -1*adj_agg['adjearn3s_cca']/public['gva_deflator'], 
        color='blue', label='Weighted')

ax.plot(boot.index, boot.q25, color='black', linestyle = '--', alpha = 0.75, label = '25/75 percentiles')
ax.plot(boot.index, boot.q75, color='black', linestyle = '--', alpha = 0.75)

ax.legend(loc='upper left', frameon=False)

ax.text(2002.2, 430, 'USDIA Income')
ax.set_ylabel('billion USD (2009 base year)')
ax.set_xlim(1981, 2017)

plt.show()
fig.savefig('../4-figures/robust.pdf', bbox_inches='tight')

## Figure 3A
fig, ax  = get_kim_fig()
ax.plot(public.index, public['poil'], color='black', linewidth=2.25)
ax.set_ylabel('dollars per barrel')
ax.set_xlim(1981,2017)
fig.savefig('../4-figures/oil_prices.pdf', bbox_inches='tight')

## Figure 3B
fig, ax  = get_kim_fig()
ax.plot(public.index, -100*adj_agg['adjearn3s_cca']/public['gvabusn'], color='blue')
ax.plot(public.index, 
        ((adj_agg['adjearn3s_cca']*(-1)) - ((adj_ind[('adjwt3s', 3240)]*(-1))*public['income_adj_factor']))/(public['gvabusn'])*100,
       color='red', linestyle='--')

ax.text(2000, 1.25, 'Adjustment\nall industries')
ax.text(2008, 0.5, 'Adjustment\nex. petroleum')


ax.set_xlim(1981, 2017)
ax.set_ylabel('share of business-sector value added (percent)')

fig.savefig('../4-figures/adjustments_nopetro.pdf', bbox_inches='tight')

## Figure 5A
fig, ax = get_kim_fig()

ax.plot(public.index, public['tradebal']/public['gdpn'], color='black')
ax.plot(public.index, (public['tradebal']-adj_agg['adjearn3s_cca'])/(public['gdpn']-adj_agg['adjearn3s_cca']), 
        color='blue', ls='--')

ax.hlines(0, 1981, 2017, color='black')

ax.set_ylim(-0.06, 0.01)
ax.set_xlim(1981, 2017)
ax.text(1997, -0.05, 'Unadjusted')
ax.text(2006, -0.014, 'Adjusted')
ax.set_ylabel('share of GDP')

fig.savefig('../4-figures/trade_balance.pdf', bbox_inches='tight')
## Figure 5(B)
fig, ax = get_kim_fig()
ax.plot(public.index, public['goodbal']/public['gdpn'], color='black', marker='o')
ax.plot(public.index, public['servbal']/public['gdpn'], color='black')

ax.plot(public.index, (public['servbal']-adj_agg['adjearn3s_cca'])/(public['gdpn']-adj_agg['adjearn3s_cca']),
        color='blue', ls='--' )

public['adj_goodbal'] = (public['goodbal']-0)/(public['gdpn']-adj_agg['adjearn3s_cca'])
ax.scatter(public.iloc[1::2].index, public.iloc[1::2]['adj_goodbal'], color='blue', marker = 'X', s=60 )


ax.hlines(0, 1981, 2017, color='black', lw=1.0)

ax.set_xlim(1981, 2017)
ax.text(2001.5, 0.024, 'Adjusted services')
ax.text(2006, 0.0017, 'Unadjusted services')

legend_els = [Line2D([0], [0], color='black', lw=2.25, marker='o', label = 'Unadjusted goods'),
             Line2D([0], [0], color='blue', lw=2.25, marker='X', markersize=9, label = 'Adjusted goods', 
             markeredgecolor='blue', linestyle='--')]

ax.legend(handles=legend_els, frameon=False, loc='lower left')

ax.set_ylabel('share of GDP')
fig.savefig('../4-figures/balances.pdf', bbox_inches='tight')

### Figure 6A
fig, ax = get_kim_fig()

ax.plot(public.index, public['fdiusinc']/(0.5*public['fdiusstks'] + 0.5*public['fdiusstks'].shift(+1))*100, color='black')
ax.plot(public.index, public['usdiainc']/(0.5*public['usdiastks'] + 0.5*public['usdiastks'].shift(+1))*100, color='black')
ax.plot(public.index, (public['usdiainc']+adj_agg['adjwt3s'])/(0.5*public['usdiastks'] + 0.5*public['usdiastks'].shift(+1))*100
        , color='blue', ls='--')

ax.set_xlim(1981, 2017)
ax.set_ylim(-2, 20)

ax.text(2002, 1, 'Unadjusted FDIUS')
ax.text(1986, 5.3, 'Adjusted USDIA')
ax.text(2005, 14, 'Unadjusted USDIA')

ax.set_ylabel('annual return (percent)')

fig.savefig('../4-figures/total_returns.pdf', bbox_inches='tight')

## Figure 6B
fig, ax = get_kim_fig()

ax.plot(public.index, public['usdiainc_nhavens']/(0.5*public['usdia_nhavens']+0.5*public['usdia_nhavens'].shift(+1))*100, 
        color='black', linestyle='-', label='Unadjusted Non-Havens')
ax.plot(public.index, (public['usdiainc_nhavens']+adj_tax[('adjwt3s', 0)])/(0.5*public['usdia_nhavens']+0.5*public['usdia_nhavens'].shift(+1))*100, 
        color='black', linestyle='--', label='Adjusted Non-Havens')
ax.plot(public.index, public['usdiainc_havens']/(0.5*public['usdia_havens']+0.5*public['usdia_havens'].shift(+1))*100, 
        color='red', linestyle='-', label='Unadjusted Havens')
ax.plot(public.index, (public['usdiainc_havens']+adj_tax[('adjwt3s', 1)])/(0.5*public['usdia_havens']+0.5*public['usdia_havens'].shift(+1))*100, 
         color='red', linestyle='--', label='Adjusted Havens')

ax.set_xlim(1981, 2017)
ax.set_ylim(-2, 22)
ax.set_ylabel('annual return (percent)')
ax.hlines(0, 1981, 2017, color='black', lw=1.0)
ax.legend(frameon=False, ncol=2)

fig.savefig('../4-figures/returns_havens_nhavens.pdf', bbox_inches='tight')

## Figure 7A
public['gdibusn'] = public['gdin'] - (public['gdpn']-public['gvabusn'])
public['gdibusr'] = public['gdibusn'] / public['gva_deflator']

prod=pd.DataFrame()
prod['uprod_log'] = np.log((public['gvabusr']*public['gdibusr'] )**(1/2)/public['hrs'])
prod['uprod_gr'] = prod['uprod_log'].diff()*100
prod['uprod_cum'] = (prod['uprod_log'] - prod.loc[1982,'uprod_log'])*100

prod['gvabusr_adj'] = (public['gvabusn']-adj_agg['adjearn3s_cca'])/public['gva_deflator']
prod['gdibusr_adj'] = (public['gdibusn']-adj_agg['adjearn3s_cca'])/public['gva_deflator']
prod['aprod_log'] = np.log((prod['gvabusr_adj']*prod['gdibusr_adj'] )**(1/2)/public['hrs'])
prod['aprod_gr'] = prod['aprod_log'].diff()*100
prod['aprod_cum'] = (prod['aprod_log'] - prod.loc[1982,'aprod_log'])*100

fig, ax = get_kim_fig()

ax.plot(prod.index, prod['uprod_cum'],color='black', label='Unadjusted')
ax.plot(prod.index, prod['aprod_cum'],color='blue',label='Adjusted', linewidth=2.25)

ax.set_ylabel('log percent')
ax.set_xlim(1981, 2017)
ax.set_ylim(-2, 75)

ax.text(2010, 60, 'Unadjusted')
ax.text(2007, 70, 'Adjusted')

ax.axvline(x=1994, color='black', lw=1.0)
ax.axvline(x=2004, color='black', lw=1.0)

fig.savefig('../4-figures/prod_all.pdf', bbox_inches='tight')

## Figure 7B
fig, ax = get_kim_fig()

ax.plot(prod.index, prod['aprod_cum']-prod['uprod_cum'],color='blue',label='Adjusted', linewidth=2.25)

ax.set_ylabel('log percent')
ax.set_xlim(1989, 2017)
ax.set_ylim(-0.25, 1.25)


ax.axvline(x=1994, color='black', lw=1.0)
ax.axvline(x=2004, color='black', lw=1.0)

fig.savefig('../4-figures/prod_diff.pdf', bbox_inches='tight')

## Table 5
intervals = [(1982, 2016), (1982,1994), (1994,2004), (2004,2016), (2004,2010),(2010,2016)]

uc, ac, ua, aa = [], [], [], [] 
for i in intervals:
    uc.append(prod.loc[i[1], 'uprod_cum'] - prod.loc[i[0], 'uprod_cum'])
    ac.append(prod.loc[i[1], 'aprod_cum'] - prod.loc[i[0], 'aprod_cum'])
    ua.append( (prod.loc[i[1], 'uprod_cum'] - prod.loc[i[0], 'uprod_cum']) / (i[1]-i[0]) )
    aa.append( (prod.loc[i[1], 'aprod_cum'] - prod.loc[i[0], 'aprod_cum']) / (i[1]-i[0]) )
    
indext = [str(i[0])+'--'+str(i[1]) for i in intervals]
    
t5 = pd.DataFrame({('Cumulative growth rate', 'Unadjusted'):uc,
              ('Cumulative growth rate', 'Adjusted'):ac,
              ('Average annual growth rate', 'Unadjusted'):ua,
              ('Average annual growth rate', 'Adjusted'):aa,}, index=indext)

formatters = [lambda x: '%.1f' % x, lambda x: '%.1f' % x, lambda x: '%.2f' % x, lambda x: '%.2f' % x]
s = t5.to_latex(formatters=formatters, column_format='lcccc')
print(s)

fout = open('../4-tables/table5.tex', 'w')
fout.write(s)
fout.close()

## Figure 8A
def read_indgroup_adjustments(indgroup):
    iadj = pd.read_excel('../0-confidential-data-replication-files/USDIA/OutputAdjNet'+indgroup+'.xlsx')
    iadj.columns = ['year', 'indgroup', 'adjcomps', 'adjsales', 'adjrdstks', 'adjppes', 'adjwt3s']
    iadj = iadj.set_index(['year', 'indgroup']).unstack()
    iadj = iadj.reindex(range(1982,2017)).interpolate()
    return iadj[('adjwt3s', 1)], iadj[('adjwt3s', 0)]

inds = pd.read_csv('../3-intermediate-files/industry.csv', index_col=0, header=[0,1])

for indgroup in ['RD', 'ITU', 'ITP']:
    inds[(indgroup.lower(), 'adjwt3s')], inds[('n'+indgroup.lower(), 'adjwt3s')] = read_indgroup_adjustments(indgroup)

inds.head(1)

fig, ax = get_kim_fig()

ax.plot(inds.index, (-100)*inds[('rd', 'adjwt3s')]/inds[('rd', 'nva')], color='blue')
ax.plot(inds.index, (-100)*inds[('nrd', 'adjwt3s')]/inds[('nrd', 'nva')], color='blue')

ax.set_ylabel('share of group\'s unadjusted value added')
ax.set_xlim(1993, 2017)
ax.set_ylim(0, 7)



ax.text(2005, 5.25, 'R&D Intensive',  ha='right')
ax.text(2007.5, 1, 'non-R&D Intensive', ha='right')



fig.savefig('../4-figures/adj_rd.pdf', bbox_inches='tight')

## Figure 8B
def logg(x):
    return (np.log(x) - np.log(x.shift(1)))
for indgroup in ['rd', 'nrd', 'itu', 'nitu', 'itp', 'nitp']:
    inds[(indgroup, 'adj_nva_gr')] = pd.DataFrame(inds[(indgroup, 'nva')] + (-1)*inds[(indgroup, 'adjwt3s')]).apply(logg)
    inds[(indgroup, 'adj_rva_gr')] = inds[(indgroup, 'adj_nva_gr')] - inds[(indgroup, 'p_gr')]
    inds[(indgroup, 'prod_adj_gr')] = inds[(indgroup, 'adj_rva_gr')] - inds[(indgroup, 'emp_gr')]
    inds[(indgroup, 'prod_adj_cgr')] = inds[(indgroup, 'prod_adj_gr')].cumsum()
    inds[(indgroup, 'prod_adj_cgr_dif')] = (inds[(indgroup, 'prod_adj_cgr')]-inds[(indgroup, 'prod_unadj_cgr')])
    inds.loc[1982,(indgroup, 'prod_adj_cgr')] = 0 

    fig, ax = get_kim_fig()

ax.plot(inds.loc[1994:2016].index, 
        100*inds.loc[1994:2016, ('rd', 'prod_adj_cgr_dif')]-100*inds.loc[1994, ('rd', 'prod_adj_cgr_dif')],
        color='blue')

ax.plot(inds.loc[1994:2016].index, 
        100*inds.loc[1994:2016,('nrd', 'prod_adj_cgr_dif')]-100*inds.loc[1994,('nrd', 'prod_adj_cgr_dif')],
        color='blue')

ax.set_ylabel('log percent')
ax.set_xlim(1993, 2017)
ax.set_ylim(-0.1, 5)

ax.axvline(x=2004, color='black', lw=1.0)
ax.text(2003, 2.75, 'R&D Intensive',  ha='right')
ax.text(2011, 0.9, 'non-R&D Intensive',  ha='right')


fig.savefig('../4-figures/prod_rd_diff.pdf', bbox_inches='tight')

## Figure 9
fig, ax = get_kim_fig()

ax.plot(inds.index, 100*inds[('rd', 'prod_adj_cgr')],color='blue')
ax.plot(inds.index, 100*inds[('rd', 'prod_unadj_cgr')],color='blue', linestyle='--')

ax.plot(inds.index, 100*inds[('nrd', 'prod_adj_cgr')],color='red')
ax.plot(inds.index, 100*inds[('nrd', 'prod_unadj_cgr')],color='red', linestyle='--')


ax.set_ylabel('log percent')
ax.set_xlim(1981, 2017)
ax.set_ylim(-0.1, 165)


ax.text(2003, 125, 'R&D Intensive',  ha='right')
ax.text(2005, 44, 'non-R&D Intensive',  ha='right')

legend_elements = [Line2D([0], [0], color='dimgray', label='Adjusted'), 
                   Line2D([0], [0], color='dimgray', linestyle='--', label='Unadjusted')]

ax.legend(handles = legend_elements, frameon=False, loc='upper left', labelcolor='dimgray')

fig.savefig('../4-figures/prod_rd_long.pdf', bbox_inches='tight')


fig, ax = get_kim_fig()

ax.plot(inds.loc[1994:].index, 
        (-100)*inds.loc[1994:,('itp', 'adjwt3s')]/inds.loc[1994:,('itp','nva')],
        color='blue', linewidth=2.25)

ax.plot(inds.loc[1994:].index, 
        (-100)*inds.loc[1994:,('nitp', 'adjwt3s')]/inds.loc[1994:,('nitp','nva')],
        color='blue', linewidth=2.25)

ax.set_ylabel('share of group\'s unadjusted value added')
ax.set_xlim(1993, 2017)
ax.set_ylim(0, 4)



ax.text(2001, 2.5, 'IT producing',  ha='right')
ax.text(2007.5, 0.37, 'non-IT producing', ha='right')

fig.savefig('../4-figures/adj_itp.pdf', bbox_inches='tight')

## Table 6
intervals = [(1982, 1994), (1994, 2016), (1994,2004), (2004,2016), (2004,2008), (2008,2016)]

rda, rdu, nrda, nrdu = [], [], [], [] 
for i in intervals:
    rda.append(inds.loc[i[1], ('rd','prod_adj_cgr')] - inds.loc[i[0], ('rd','prod_adj_cgr')])
    rdu.append(inds.loc[i[1], ('rd','prod_unadj_cgr')] - inds.loc[i[0], ('rd','prod_unadj_cgr')])
    nrda.append(inds.loc[i[1], ('nrd','prod_adj_cgr')] - inds.loc[i[0], ('nrd','prod_adj_cgr')])
    nrdu.append(inds.loc[i[1], ('nrd','prod_unadj_cgr')] - inds.loc[i[0], ('nrd','prod_unadj_cgr')])
    
    
    
indext = [str(i[0])+'--'+str(i[1]) for i in intervals]
    
t6 = pd.DataFrame({('RD', 'Adjusted'):rda,('RD','Unadjusted'):rdu,('NRD','Adjusted'):nrda,('NRD','Unadjusted'):nrdu}, index=indext).transpose()*100

cols = ['level_1'] + t6.columns.to_list()
t6 = t6.reset_index()
t6['level_1'] = '\hspace{2ex}' + t6['level_1']

s = t6.to_latex(float_format='%.1f', column_format='lSSSSS', escape=False, columns=cols, index=False)
s = add_after(s, '\midrule', 'R\&D intensive&&&&&\\\\')
s = add_after(s, '\hspace{2ex}Unadjusted', 'Non-R\&D intensive&&&&&\\\\')

print(s)
fout = open('../4-tables/table6.tex', 'w')
fout.write(s)
fout.close()

## Figure 10A
fig, ax = get_kim_fig()

ax.plot(public.index, public['compn']/(public['corpincn']+public['cfcn']), color='black')
ax.plot(public.index, public['compn']/(public['corpincn']+public['cfcn']-adj_agg['adjearn3s_cca']), color='blue')

ax.set_xlim(1981, 2017)
#ax.set_ylim(0, 4.5)


ax.text(2002.5, 0.64, 'Unadjusted')
ax.text(2002, 0.57, 'Adjusted')


ax.set_ylabel('share of income')
fig.savefig('../4-figures/gross_labor_share.pdf', bbox_inches='tight')

## Figure 11A
fdius12 = pd.read_csv('../0-confidential-data-replication-files/FDIUS/FigureForPaper2012.csv', index_col='year')
fdius12 = fdius12.sort_values('WtdShrEmpCompPPE')

fig, ax = get_kim_fig()
ax.plot(fdius12.WtdShrEmpCompPPE, fdius12.LowessFitted, color='b', linestyle='-', linewidth=2.25)
ax.plot(fdius12.WtdShrEmpCompPPE, fdius12.RegFitted, 'r--' , linewidth=2.25)


# 45 degree line
x = np.linspace(*ax.get_xlim())
ax.plot(x, x, 'k', linewidth=2.25)
    
ax.set_xlim(0, 0.75)
ax.set_ylim(0, 0.75)
ax.set_ylabel('U.S. share of worldwide profit')
ax.set_xlabel('U.S. apportionment weight')

ax.annotate('45-degree line', xy=(0.40, 0.6), backgroundcolor='white')
ax.annotate('OLS fitted value', xy=(0.46, 0.41), backgroundcolor='white')
ax.annotate('Lowess smoothed value', xy=(0.45,0.20), backgroundcolor='white')

fig.savefig('../4-figures/fdius12.pdf', bbox_inches='tight')

plt.show()

## Figure 11B

fdius15 = pd.read_csv('../0-confidential-data-replication-files/FDIUS/FigureForPaper2015.csv', index_col='year')
fdius15 = fdius15.sort_values('WtdShrEmpCompPPE')

fig, ax = get_kim_fig()
ax.plot(fdius15.WtdShrEmpCompPPE, fdius15.LowessFitted, color='b', linestyle='-', linewidth=2.25)
ax.plot(fdius15.WtdShrEmpCompPPE, fdius15.RegFitted, 'r--' , linewidth=2.25)


# 45 degree line
x = np.linspace(*ax.get_xlim())
ax.plot(x, x, 'k', linewidth=2.25)
    
ax.set_xlim(0, 0.75)
ax.set_ylim(0, 0.75)
ax.set_ylabel('U.S. share of worldwide profit')
ax.set_xlabel('U.S. apportionment weight')

ax.annotate('45-degree line', xy=(0.40, 0.6), backgroundcolor='white')
ax.annotate('OLS fitted value', xytext=(0.57, 0.35), xy=(0.43,0.38),arrowprops=dict(facecolor='black', arrowstyle='->'),  backgroundcolor='white')
ax.annotate('Lowess smoothed value', xy=(0.40,0.27), backgroundcolor='white')

fig.savefig('../4-figures/fdius15.pdf', bbox_inches='tight')

plt.show()

import pandas as pd

def add_after(text, beginswith, toinsert):
    '''Adds a row to a latex table. 
    Inserts the string `toinsert` into the table string `text` 
    after the row that begins with `beginswith`.'''
    ss = text.splitlines()
    
    ii = '0'
    for i, l in enumerate(ss):
        if l.startswith(beginswith) == True:
            ii = i
    
    # This will throw an error if beginswith is not found.
    ss.insert(ii+1, toinsert)
    return '\n'.join(ss)

## Table 1

ctys = ['All Countries Total', 'Canada', 'Ireland', 'Luxembourg', 'Netherlands', 'Switzerland',
        'Barbados', 'Bermuda', 'United Kingdom Islands, Caribbean', 'Hong Kong', 'Singapore']

missing = ['(*)', 'G', 'A', 'n.s.', 'H', '(D)']

# Employees are in thousands. Express them in people. 
emp = pd.read_csv('../1-raw-data/usdia-employees-2012.csv', header = 5, nrows=234, na_values=missing, converters = {0: str.strip}, index_col=[0])
emp.columns = ['emp']
emp = emp*1000

ast = pd.read_csv('../1-raw-data/usdia-total-assets-2012.csv', header = 5, nrows=234, na_values=missing, converters = {0: str.strip}, index_col=[0])
ast.columns = ['assets']

comp = pd.read_csv('../1-raw-data/usdia-comp-2012.csv', header = 5, nrows=234, na_values=missing, converters = {0: str.strip}, index_col=[0])
comp.columns = ['comp']

ppe = pd.read_csv('../1-raw-data/usdia-ppe-2012.csv', header = 5, nrows=234, na_values=missing, converters = {0: str.strip}, index_col=[0])
ppe.columns = ['ppe']

t1 = pd.merge(left=emp, right=ast, left_index=True, right_index=True, how = 'inner')
t1 = pd.merge(left=t1, right=comp, left_index=True, right_index=True, how = 'inner')
t1 = pd.merge(left=t1, right=ppe, left_index=True, right_index=True, how = 'inner')

t1 = t1.loc[ctys].copy()
t1['Employment'] = t1['assets']/t1['emp']
t1['Compensation'] = t1['assets']/t1['comp']
t1['PPE'] = t1['assets']/t1['ppe']
t1 = t1[['PPE', 'Compensation', 'Employment']]

t1 = t1.rename(index={'All Countries Total':'World', 'United Kingdom Islands, Caribbean':'U.K.I., Caribbean'})

s = t1.to_latex(float_format="%.1f", column_format='lSSS', caption='Assets in U.S.-owned foreign affiliates, 2012', escape=False)
s = add_after(s, 'Canada', '[1ex]')
s = add_after(s, 'Switzerland', '[1ex]')
s = add_after(s, 'U.K.I., Caribbean', '[1ex]')

print(s)
fout = open('../4-tables/table1.tex', 'w')
fout.write(s)
fout.close()

## Table 2

ctys = ['Netherlands', 'Bermuda', 'Ireland', 'Luxembourg', 'United Kingdom Islands, Caribbean[2]',
        'Switzerland', 'Singapore', 'Japan', 'Germany', 
        'United Kingdom', 'France', 'China', 'Italy', 'Canada']

usdia_inc = pd.read_excel('../1-raw-data/usdiainc_country.xls', header=6, nrows=253, na_values=['n.s.', '...', '(D)', '(*)', '---','--', '----'],
                       index_col='Unnamed: 0')
usdia_inc.index = usdia_inc.index.str.strip()

usdia_inc.head(1)

agg_data = pd.read_csv('../3-intermediate-files/aggregate.csv', index_col=['year'])
iaf16 = agg_data.loc[2016, 'income_adj_factor']

cty_adj = pd.read_excel('../0-confidential-data-replication-files/USDIA/OutputAdjNetCountry2016.xlsx', 
                   index_col='CountryName')
cty_adj = cty_adj.rename(index={'UK Islands - Caribbean':'United Kingdom Islands, Caribbean[2]',
                                'UK': 'United Kingdom'})

temp = pd.concat([cty_adj.loc[ctys], usdia_inc.loc[ctys, '2016']], axis=1)

temp['total adjustment earn'] = (temp['adjwt3s'])*iaf16

total_adj_earn = cty_adj['adjwt3s'].sum()*iaf16

temp['share adj earn'] = temp['total adjustment earn']/total_adj_earn*100
temp['share income'] = ((temp['adjwt3s']-temp['nips'])/(temp['2016'])*100*1000).abs()
temp.head(1)

pos = ['Netherlands', 'Bermuda', 'Ireland', 'Luxembourg', 
                  'United Kingdom Islands, Caribbean[2]', 'Switzerland', 'Singapore']
neg = ['Germany', 'France', 'United Kingdom',  'Canada',    'Italy', 'China','Japan']

t2 = temp.loc[pos, ['share adj earn', 'share income']]
negs = temp.loc[neg, ['share adj earn', 'share income']].reset_index()
negs['share adj earn'] = negs['share adj earn']*(-1)
negs = negs.rename(index=dict(zip(range(0,7),pos)))
t2 = pd.concat( [t2, negs], axis=1).reset_index()

t2.loc[t2['level_0']=='United Kingdom Islands, Caribbean[2]', 'level_0'] = 'U.K.I., Caribbean'
t2['index'] = '\hspace{1ex}' + t2['index']
t2['level_0'] = '\hspace{1ex}' + t2['level_0']


formatters=[lambda x: '%s' % x, lambda x: '%.1f' % x, lambda x: '%.1f' % x, 
            lambda x: '%s' % x, lambda x: '%.2f' % x, lambda x: '%.1f' % x]
            
s = t2.to_latex(formatters = formatters, column_format='lcclc', index=False, escape=False)

print(s)
fout = open('../4-tables/table2.tex', 'w')
fout.write(s)
fout.close()

## Table 4
t4 = pd.read_excel('../0-confidential-data-replication-files/USDIA/OutputAdjNetIndustry.xlsx', 
                   usecols=['Year','IEDindPar','adjwt3s'])
t4 = t4[t4['Year']==2016]

ied = pd.read_csv('../1-raw-data/author-created-concordances/ied-codes.csv')
t4 = pd.merge(left=t4, right=ied, left_on='IEDindPar', right_on='IED Code')

t4['total adjustment'] = t4['adjwt3s']*iaf16
total_adj = t4['total adjustment'].sum()
t4 = t4[['NAICS', 'NAICS Description', 'total adjustment']].groupby(['NAICS', 'NAICS Description']).sum().sort_values('total adjustment')
t4['share of adjustment'] = t4['total adjustment']/total_adj*100
t4 = t4.reset_index()
t4.head(1)

nva_ind = pd.read_csv('../1-raw-data/va-by-industry-97-16.csv', header=4, nrows=98)
nva_ind = nva_ind[['Unnamed: 1', '2016']]
nva_ind['Description nva'] = nva_ind['Unnamed: 1'].str.strip()

reps = {'Publishing industries, except internet (includes software)':'Publishing industries',
       'Data processing, internet publishing, and other information services':'Information and data processing services'}

nva_ind['Description nva'] = nva_ind['Description nva'].replace(reps)

nva_ind = pd.merge(left=nva_ind, right=ied, left_on='Description nva', right_on='Description', how='inner')
nva_ind = nva_ind.groupby('NAICS').sum().reset_index()

t4 = pd.merge(left=t4, right=nva_ind[['NAICS', '2016']], on='NAICS')
t4['share of va'] = t4['total adjustment']/t4['2016']*100*(-1)

pretty_names = {'Metals, machinery, computers, electrical equipment, motor vehicles, furniture':'Computers, electrical equip., motor vehicles',
                'Wood, paper, printing, petroleum, chemicals, plastics':'Petroleum, chemicals, plastics, wood, paper',
                'Professional and business services':'Legal, computer sys. design, scientific R\&D',
                'Information':'Publishing, information, data processing',
                'Finance and insurance': 'Finance, insurance',
               'Real estate and rental and leasing':'Real estate, leasing',
               'Administrative and waste management services':'Administrative services',
               'Transportation and warehousing':'Transportation, warehousing',
               'Educational services, health care, and social assistance':'Education, health care',
               'Arts, entertainment, recreation, accommodation, and food services':'Arts, entertainment, accommodation'}

t4['NAICS Description'] = t4['NAICS Description'].replace(pretty_names)
t4['Key industries'] = t4['NAICS'].astype(str) + ' ' + t4['NAICS Description']
t4 = t4.drop(['NAICS Description', 'NAICS', 'total adjustment', '2016'], axis=1)

t4 = t4[['Key industries', 'share of adjustment', 'share of va']]

s = t4.to_latex(float_format='%.2f', column_format='lSS', index=False, escape=False)
print(s)
fout = open('../4-tables/table4.tex', 'w')
fout.write(s)
fout.close()

## Table 7
stata = pd.read_excel('../0-confidential-data-replication-files/FDIUS/TableForPaper.xlsx', 
                      sheet_name='Stata Output', index_col='Year')

rd = pd.read_excel('../0-confidential-data-replication-files/FDIUS/TableForPaper.xlsx', 
                      sheet_name='BEA AMNE FDIUS RD', header=6, nrows=1, index_col=[0]).transpose()
rd.index = rd.index.astype(int)
rd = rd.rename(columns={'All Industries Total':'total rd'})

emp = pd.read_excel('../0-confidential-data-replication-files/FDIUS/TableForPaper.xlsx', 
                      sheet_name='BEA AMNE FDIUS Emp', header=6, nrows=1, index_col=[0]).transpose()
emp.index = emp.index.astype(int)
emp = emp.rename(columns={'All Industries Total':'total emp'})

t7 = pd.merge(left=stata, right=rd, left_index=True, right_index=True)
t7 = pd.merge(left=t7, right=emp, left_index=True, right_index=True)

t7['rd share'] = t7['RD']/t7['total rd']/1000
t7['emp share'] = t7['Employees']/t7['total emp']/1000
t7['shifted profit'] = t7['AdjFA']/1000000

t7.head(1)

usdia = pd.read_excel('../0-confidential-data-replication-files/USDIA/OutputAdjNet.xlsx', 
                      usecols=['Year', 'adjwt3s'])
usdia = pd.merge(left=usdia, right=agg_data['income_adj_factor'], left_on='Year', right_index=True)

usdia['usdia shifted profit'] = usdia['income_adj_factor']*usdia['adjwt3s']*(-1)

t7 = pd.merge(left=t7, right=usdia, left_index = True, right_on='Year', how='left')
t7.head(1)

t7 = t7[['Year', 'N', 'rd share', 'emp share', 'shifted profit', 'usdia shifted profit']]

formatters=[lambda x: '%.0f' % x, lambda x: '%.0f' % x, lambda x: '%.2f' % x, 
            lambda x: '%.2f' % x, lambda x: '%.1f' % x, lambda x: '%.1f' % x]
            
s = t7.to_latex(formatters = formatters, column_format='lccccc', index=False, escape=False)

print(s)
fout = open('../4-tables/table7.tex', 'w')
fout.write(s)
fout.close()
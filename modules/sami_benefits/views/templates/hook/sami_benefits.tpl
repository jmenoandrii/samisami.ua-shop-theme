{$homeBenefitsName = 'home-benefits'}

<section class="{$homeBenefitsName}__container">
    <div class="{$homeBenefitsName}__wrapper">
        {foreach from=$benefits item=benefit}
            <div class="{$homeBenefitsName}__item">
                <div class="benefit-icon">
                    <i class="fa {$benefit.icon}"></i>
                </div>
                <div class="benefit-title">
                    <h3>{$benefit.title}</h3>
                </div>
            </div>
        {/foreach}
    </div>
</div>

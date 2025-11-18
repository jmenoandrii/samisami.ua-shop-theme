{$homeBenefitsName = 'home-benefits'}

<section class="{$homeBenefitsName}">
    <div class="{$homeBenefitsName}__wrapper">
        {foreach from=$benefits item=benefit}
            <div class="{$homeBenefitsName}__item">
                <i class="{$homeBenefitsName}__icon material-symbols-outlined" aria-hidden="true">{$benefit.icon}</i>
                <h3 class="{$homeBenefitsName}__title">{$benefit.title}</h3>
            </div>
        {/foreach}
    </div>
</section>

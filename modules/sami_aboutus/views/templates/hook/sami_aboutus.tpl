{$homeAboutUs = 'home-about-us'}

<section class="{$homeAboutUs}">
    <div class="{$homeAboutUs}__container sami-container">
        {if $sami_about_image}
        <div class="{$homeAboutUs}__image-wrapper" 
            style="
            background-image: url('{$sami_about_image}');
            ">
        </div>
        {/if}
        
        <div class="{$homeAboutUs}__content">
            {if $sami_about_title}
            <h2 class="{$homeAboutUs}__title">
                {$sami_about_title|escape:'html':'UTF-8'}
            </h2>
            {/if}
            
            {if $sami_about_description}
            <div class="{$homeAboutUs}__description">
                {$sami_about_description nofilter}
            </div>
            {/if}
            
        </div>
    </div>
</section>
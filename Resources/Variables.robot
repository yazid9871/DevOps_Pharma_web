*** Settings ***
Documentation     Fichier contenant les variables utilisées dans les tests.
Library           SeleniumLibrary

*** Variables ***

${BASE_URL}   https://app.pharma.sobrus.ovh

# --- Boutons d'action ---
${BOUTON_RECHERCHE}                 xpath=//*[@data-testid="recherche"]
${BOUTON_ACTUALISER}                 xpath=//button[contains(., 'Rafraichir')]
${BOUTON_RECHERCHE_AVANCEE}          xpath=//*[@data-testid="recherche_avancée"]
${BOUTON_IMPRIMER}                   xpath=//*[@data-testid="imprimer_"]
${BOUTON_CREER}                      xpath=//*[@data-testid="créer"]
${BOUTON_ARCHIVES}                    xpath=//*[@data-testid="archives"]
${BOUTON_ACTUEL}                      xpath=//*[@data-testid="actuel"]
${BOUTON_IMPORTER}                     xpath=//*[@data-testid="importer"]
${SEARCH_BUTTON}                 xpath=//*[@data-testid="recherche"]
${REFRESH_BUTTON}      xpath=//button[contains(., 'Rafraichir')]
${SEARCH_BUTTON2}      xpath=//table[contains(@class, 'sob-v2-table')]//thead//tr//td//button
${BOUTON_CREER}                  xpath=//*[@data-testid="créer"]
${BOUTON_FERMER_RECHECHE}                  xpath=//*[@data-testid="fermer_la_recherche"]


# --- tableau et icônes ---
${LISTE_DEROULANTE}      css=.sob-v2-select__option:nth-child(2)
${EDIT_ICON}                          xpath=//*[@data-tooltip-id='edit']
${PAIMENT_ICON}                          xpath=//*[@data-tooltip-id='payment']
${ICONE_ENVOYER_MESSAGE}              xpath=//*[@data-tooltip-id='contact']
${ICONE_IMPRIMER}                    xpath=//*[@data-tooltip-id="print"]
${table}                          //table[contains(@class, 'sob-v2-table')]//tbody//tr

# --- Champs   General  ---
${CHAMP_EMAIL}                  id=email
${CHAMP_TÉLÉPHONE}              id=phone

# --- Champs  Liste  Client ---
${CHAMP_NOM_CLIENT}                    id=name
${CHAMP_ORGANISME_AMO}                 id=payer_id.q
${CHAMP_N_IMMATRICULATION_AMO}         id=payer_registration_number
${CHAMP_ORGANISME_AMC}                 id=complementary_payer_id.q
${CHAMP_N_IMMATRICULATION_AMC}         id=complementary_payer_registration_number
#${CHAMP_POINTS_DE_FIDÉLITÉ}
#${CHAMP_SOLDE}


# ---Chanps  Liste  Contact ---
${CHAMP_PRENOM_CONTACT}           id=first_name
${CHAMP_NOM_CONTACT}             id=last_name
${CHAMP_TITRE_CONTACT}            id=title
${CHAMP_CLIENT_CONTACT}         id=customer_id_name

# --- Champs Liste Paiements Fatourati ---
${CHAMP_CLIENT_PAIEMENT}         id=customer_id_name
${CHAMP_MONTANT_PAIEMENT}        id=amount
${CHAMP_DATE_PAIEMENT}           id=created_on.q
${CHAMP_STATUT_PAIEMENT}         id=status.q
${BOUTON_syn_CMI}                xpath=//*[@data-testid="synchroniser_avec_cmi"]

# --- Champs Liste Produits ---
${CHAMP_NOM_PRODUIT}              id=name
${CHAMP_PPV_PRODUIT}              id=sale_price
${CHAMP_PPH_PRODUIT}              id=purchase_price
${CHAMP_CODE_BARRE_PRODUIT}        id=barcode
${CHAMP_CATEGORIE_PRODUIT}         id=product_category_id.q
${CHAMP_FORME_GALENIQUE_PRODUIT}   id=product_galenic_form_id.q
${CHAMP_ZONE_PRODUIT}              id=zone_id.q
${CHAMP_RAISON_PRODUIT}            id=deactivation_reason.q
${BOUTON_SUGGERER_PRODUIT}        xpath=//*[@data-testid="suggérer_un_nouveau_produit"]
${BOUTON_METTRE_A_JOUR_PRIX_PRODUITS}    xpath=//*[@data-tooltip-id="suggested-prices"]
${BOUTON_HISTORIQUE_SUGGESTIONS}         xpath=//*[@data-testid="historique_des_suggestions"]
${CHAMP_STATUT_PRODUIT}              id=status.q
${CHAMP_RAISON_SUGGERE_PRODUIT}              id=rejection_reason_id.q

# --- Champs Liste Ventes ---
${CHAMP_NUM_TRANSACTION_VENTE}     id=transaction_number
${CHAMP_CLIENT_VENTE}              id=customer_id_name
${CHAMP_DATE_VENTE}                id=invoice_date.q
${CHAMP_CREE_LE_VENTE}             id=created_on.q
${CHAMP_TOTAL_VENTE}               id=total
${CHAMP_LIVRE_VENTE}               id=is_delivered.q
${CHAMP_STATUT_VENTE}              id=status.q

# --- Champs Liste Devis ---
${CHAMP_NUM_TRANSACTION_DEVIS}      id=transaction_number
${CHAMP_CLIENT_DEVIS}               id=customer_name
${CHAMP_VALABLE_JUSQUAU_DEVIS}      id=valid_until.q
${CHAMP_TOTAL_DEVIS}                id=total
${CHAMP_STATUT_DEVIS}               id=status.q

# --- Champs Liste Retours sur ventes ---
${CHAMP_NUM_TRANSACTION_RETOUR}      id=transaction_number
${CHAMP_CLIENT_RETOUR}               id=customer_id_name
${CHAMP_DATE_RETOUR}                 id=date.q
${CHAMP_MONTANT_RESTITUE_RETOUR}     id=amount_given_back
${CHAMP_MODE_REMBOURSEMENT_RETOUR}   id=given_back_via_credit.q
${CHAMP_STATUT_RETOUR}               id=status.q

# --- Champs Liste Préparations ---
${CHAMP_CLIENT_PREPARATION}          id=customer_id_name
${CHAMP_NUM_TRANSACTION_PREPARATION}  id=transaction_number
${CHAMP_TYPE_PREPARATION}            id=type.q
${CHAMP_DATE_PREPARATION}            id=date.q
${CHAMP_QTE_PRODUIT_PREPARATION}     id=resulting_product_quantity
${CHAMP_PRIX_UNI_PREPARATION}        id=resulting_product_price
${CHAMP_STATUT_PREPARATION}          id=status.q

# --- Champs Liste_Factures_globales ---
${CHAMP_NUM_TRANSACTION_FACTURE_GLOBALE}    id=transaction_number
${CHAMP_CLIENT_FACTURE_GLOBALE}             id=customer_id_name
${CHAMP_DATE_VENTE_FACTURE_GLOBALE}         id=invoice_date.q
${CHAMP_CREE_PAR_FACTURE_GLOBALE}           id=created_by.q
${CHAMP_CREE_LE_FACTURE_GLOBALE}            id=created_on.q
${CHAMP_TOTAL_FACTURE_GLOBALE}              id=total

# --- Champs Liste Bons de livraison ---
${CHAMP_NUM_TRANSACTION_BON_LIVRAISON}         id=transaction_number
${CHAMP_FOURNISSEUR_BON_LIVRAISON}             id=supplier_id_name
${CHAMP_DATE_BON_LIVRAISON}                    id=delivery_note_date.q
${CHAMP_CREE_LE_BON_LIVRAISON}                 id=created_on.q
${CHAMP_TOTAL_BON_LIVRAISON}                   id=total
${CHAMP_REFERENCE_LIVRAISON_BON_LIVRAISON}     id=delivery_reference
${CHAMP_STATUT_BON_LIVRAISON}                  id=status.q
${BOUTON_SCANNER}                      xpath=//*[@data-tooltip-id='ocr-tooltip']

# --- Champs Liste Bons de commandes ---
${CHAMP_NUM_TRANSACTION_BON_COMMANDE}          id=transaction_number
${CHAMP_FOURNISSEUR_BON_COMMANDE}              id=supplier_id_name
${CHAMP_DATE_BON_COMMANDE}                     id=purchase_order_date.q
${CHAMP_CREE_LE_BON_COMMANDE}                  id=created_on.q
${CHAMP_TOTAL_BON_COMMANDE}                    id=total
${CHAMP_STATUT_BON_COMMANDE}                   id=status.q
${BOUTON_MULTI_FOURNISSEURS}                 xpath=//*[@data-testid="commande_multi-fournisseurs"]
${BOUTON_DISPONIBILITE}                 xpath=//*[@data-testid="vérifier_la_disponibilité"]
${EDIT_CONVERTIR_EN_BL}                 xpath=//*[@data-testid="convertir_en_bl"]

# --- Champs Liste Avoirs fournisseurs émis ---
${CHAMP_NUM_TRANSACTION_AVOIR_FOURNISSEUR}     id=transaction_number
${CHAMP_FOURNISSEUR_AVOIR_FOURNISSEUR}         id=supplier_id_name
${CHAMP_DATE_AVOIR_FOURNISSEUR}                id=date.q
${CHAMP_TOTAL_EMIS_AVOIR_FOURNISSEUR}          id=total_issued
${CHAMP_TOTAL_ATTENTE_AVOIR_FOURNISSEUR}       id=total_pending
${CHAMP_STATUT_AVOIR_FOURNISSEUR}              id=status.q

# --- Champs Liste Avoirs fournisseurs reçus ---
${CHAMP_NUM_TRANSACTION_AVOIR_RECU}            id=transaction_number
${CHAMP_REFERENCE_AVOIR_RECU}                  id=supplier_credit_note_id_name
${CHAMP_FOURNISSEUR_AVOIR_RECU}                id=supplier_id_name
${CHAMP_DATE_AVOIR_RECU}                       id=date.q
${CHAMP_TOTAL_ACCEPTE_AVOIR_RECU}              id=total_accepted
${CHAMP_TOTAL_REFUSE_AVOIR_RECU}               id=total_refused
${CHAMP_MONTANT_RECU_AVOIR_RECU}               id=amount_received
${CHAMP_MODE_REMBOURSEMENT_AVOIR_RECU}         id=received_as_credit.q
${CHAMP_STATUT_AVOIR_RECU}                     id=status.q

# --- Champs Liste Commandes groupées ---
${CHAMP_NO_BC_GROUPEE}                  id=orderId
${CHAMP_OFFRE_BC_GROUPEE}                id=offerName
${CHAMP_GROUPE_BC_GROUPEE}               id=groupId.q
${CHAMP_MANAGER_BC_GROUPEE}              id=managerId.q
${CHAMP_FOURNISSEUR_BC_GROUPEE}          id=supplierId.q
${CHAMP_DEADLINE_BC_GROUPEE}             id=offerDeadline.q
${CHAMP_MISE_A_JOUR_BC_GROUPEE}          id=updatedAt.q
${CHAMP_QTE_TOTALE_BC_GROUPEE}           id=orderedQuantity
${CHAMP_STATUT_BC_GROUPEE}               id=groupedOrderStatus.q
${CHAMP_STATUT_LIVRAISON_BC_GROUPEE}     id=orderStatus.q
${BOUTON_RECHERCHE_BC_GROUPEE}           xpath=//*[@data-testid="search"]
${BOUTON_ACTUALISER_BC_GROUPEE}          xpath=//button[contains(., 'Rafraichir') or contains(., 'Refresh')]

# --- Champs Liste Fournisseurs ---
${CHAMP_NOM_FOURNISSEUR}                 id=name
${CHAMP_TELEPHONE_FOURNISSEUR}           id=phone
${CHAMP_VILLE_FOURNISSEUR}               id=city
${CHAMP_SOLDE_FOURNISSEUR}               id=balance
${BOUTON_SUGGERER_FOURNISSEUR}           xpath=//*[@data-testid="suggérer_un_nouveau_fournisseur"]

# --- Champs Liste Suggestions de fournisseurs ---
${CHAMP_SUPPLIER_SUGGESTION_FOURNISSEUR}     id=supplier_id_name
${CHAMP_NOM_SUGGESTION_FOURNISSEUR}          id=name
${CHAMP_TELEPHONE_SUGGESTION_FOURNISSEUR}    id=phone
${CHAMP_VILLE_SUGGESTION_FOURNISSEUR}        id=city
${CHAMP_STATUT_SUGGESTION_FOURNISSEUR}       id=status.q
${CHAMP_RAISON_SUGGESTION_FOURNISSEUR}       id=rejection_reason_id.q

# --- Champs Liste Confrères ---
${CHAMP_CIN_CONFRERE}                    id=cin
${CHAMP_CNSS_CONFRERE}                   id=cnss
${CHAMP_SOLDE_CONFRERE}                  id=balance
${BOUTON_ARCHIVES}                    xpath=//*[@data-testid="archives"]


# --- Champs Liste Entrées confrères ---
${CHAMP_CONFRERE_ENTREE_CONFRERE}        id=colleague_id_name
${CHAMP_DATE_ENTREE_CONFRERE}            id=date.q
${CHAMP_CREE_LE_ENTREE_CONFRERE}         id=created_on.q
${CHAMP_CHAMP_TARIFICATION_ENTREE_CONFRERE}   id=pricing_field.q
${CHAMP_TOTAL_ENTREE_CONFRERE}           id=total
${CHAMP_STATUT_ENTREE_CONFRERE}          id=status.q

# --- Champs Liste Sorties confrères ---
${CHAMP_CONFRERE_SORTIE_CONFRERE}        id=colleague_id_name
${CHAMP_DATE_SORTIE_CONFRERE}            id=date.q
${CHAMP_CREE_LE_SORTIE_CONFRERE}         id=created_on.q
${CHAMP_CHAMP_TARIFICATION_SORTIE_CONFRERE}   id=pricing_field.q
${CHAMP_TOTAL_SORTIE_CONFRERE}           id=total
${CHAMP_STATUT_SORTIE_CONFRERE}          id=status.q

# --- Champs Liste Organismes ---
${CHAMP_TELEPHONE_ORGANISME}             id=phone
${CHAMP_VILLE_ORGANISME}                 id=city
${CHAMP_DEBIT_ORGANISME}                 id=debit

# --- Champs Liste Factures organismes ---
${CHAMP_NUM_TRANSACTION_FACTURE_ORGANISME}     id=transaction_number
${CHAMP_BENEFICIAIRE_FACTURE_ORGANISME}        id=beneficiary
${CHAMP_DATE_FACTURE_ORGANISME}                id=invoice_date.q
${CHAMP_NUM_DOSSIER_FACTURE_ORGANISME}         id=payer_file_number
${CHAMP_NUM_PRISE_EN_CHARGE_FACTURE_ORGANISME}   id=payer_coverage_number
${CHAMP_TOTAL_CLIENT_FACTURE_ORGANISME}        id=total_customer
${CHAMP_TOTAL_ORGANISME_FACTURE_ORGANISME}     id=total_payer
${CHAMP_STATUT_ORGANISME_FACTURE_ORGANISME}    id=payer_status.q
${CHAMP_STATUT_FACTURE_ORGANISME}              id=status.q

# --- Champs Liste Bordereaux d'envoi ---
${CHAMP_PAYEUR_BORDEREAU_ENVOI}          id=payer_id.q
${CHAMP_DATE_BORDEREAU_ENVOI}            id=date.q
${CHAMP_TOTAL_CLIENT_BORDEREAU_ENVOI}    id=total_customer
${CHAMP_TOTAL_ORGANISME_BORDEREAU_ENVOI}   id=total_payer
${CHAMP_TOTAL_BORDEREAU_ENVOI}           id=total

# --- Champs Liste Stock ---
${CHAMP_PRODUIT_STOCK}                   id=product_id_name
${CHAMP_STOCK_MAIN_STOCK}                id=on_hand
${CHAMP_DEJA_VENDU_STOCK}                id=sold
${CHAMP_DISPONIBLE_STOCK}                id=available
${CHAMP_COMMANDE_STOCK}                  id=ordered
${CHAMP_VALEUR_ACHAT_STOCK}              id=value_in_purchase_price
${CHAMP_VALEUR_VENTE_STOCK}              id=value_in_sale_price
${CHAMP_ZONE_STOCK}                      id=zone_id.q
${CHAMP_DATE_EXPIRATION_STOCK}           id=expiry_date.q
${CHAMP_CODE_BARRE_STOCK}                id=barcode
${CHAMP_CODE_BARRE_2_STOCK}              id=barcode_2
${BOUTON_LISTE_INVENTAIRES}              xpath=//*[@data-testid="liste_des_inventaires"]
${BOUTON_LISTE_IMPORTS}              xpath=//*[@data-testid="liste_des_imports"]
${BOUTON_REMISE_ZERO_DU_STOcK}              xpath=//*[@data-testid="remise_à_zero_du_stock"]


# --- Champs Liste Inventaires ---
${CHAMP_NUM_TRANSACTION_INVENTAIRE}      id=transaction_number
${CHAMP_DATE_INVENTAIRE}                 id=date.q
${CHAMP_METHODE_INVENTAIRE}              id=method.q
${CHAMP_FORME_GALENIQUE_INVENTAIRE}      id=product_galenic_form_id.q
${CHAMP_ZONE_INVENTAIRE}                 id=zone_id.q
${CHAMP_STATUT_INVENTAIRE}               id=status.q
${CHAMP_MODIFIE_PAR_INVENTAIRE}          id=updated_by
${CHAMP_CREE_PAR_INVENTAIRE}             id=created_by
${CHAMP_CREE_LE_INVENTAIRE}              id=created_on.q
${CHAMP_MODIFIE_LE_INVENTAIRE}           id=updated_on.q
${CHAMP_FOURNISSEUR_CONTACT}               id=supplier_id_name
${BOUTON_DEMANDER_MON_INVENTAIRE}           id=inventory
${BOUTON_DEMArrer_INVENTAIRE}              xpath=//*[@data-testid="démarrer_l’inventaire_guidé"]

# ----- Page_détails  -----
${loop_button}   xpath=//div[@class='table__search__inputs']//button[@data-testid='false']
${BOUTON_APPROUVER}                 xpath=//*[@data-testid="approuver"]
${BOUTON_AUTRE_ACTION}               css=button.sob-v2-btn-tertiary:nth-child(2)
# ----- Page_détails_Fournisseur    -----
${BOUTON_CREER_CONTACT_FOURNISSEUR}                 xpath=//div[@id='suppliercontacts']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_CREER_BC_FOURNISSEUR}                 xpath=//div[@id='supplierpurchase_orders']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_CREER_BL_FOURNISSEUR}                 xpath=//div[@id='supplierdelivery_notes']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_CREER_VOIR_EMIE_FOURNISSEUR}                 xpath=//div[@id='supplierissued_purchases_returns']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_CREER_VOIR_RECUE_FOURNISSEUR}                 xpath=//div[@id='supplierpurchases_returns']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_SUGGERER_MODIFICATION}                        xpath=//*[@data-testid="suggérer_une_modification"]
${BOUTON_SUGGERER_MODIFICATION}                        xpath=//*[@data-testid="suggérer_une_modification"]
${BOUTON_PAYER_BL_IMPAYEE}                        xpath=//*[@data-testid="payer_les_bons_de_livraison_impayés"]

# ----- Page_détails_Confrères    -----
${BOUTON_CREER_ENCAISSEMENT_CONFRERE}            xpath=//div[@id='colleagueincoming_payments']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_CREER_DECAISSEMENT_CONFRERE}            xpath=//div[@id='colleagueoutgoing_payments']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_CREER_SORTIE_CONFRERE}                  xpath=//div[@id='colleaguecolleague_sales']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_CREER_ENTREE_CONFRERE}                  xpath=//div[@id='colleaguecolleague_purchases']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_ARCHIVER_CONFRERE}                      xpath=//*[@data-testid="archiver"]
${BOUTON_MODIFIER_CONFRERE}                      xpath=//*[@data-testid="modifier"]
${BOUTON_IMPRIMER_RELEVE_CONFRERE}               xpath=//*[@data-testid="imprimer_le_relevé"]

# ----- Page_détails_Organismes    -----
${BOUTON_CREER_VENTE_ORGANISME}                  xpath=//div[@id='payersinvoices']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_CREER_BORDEREAU_ORGANISME}              xpath=//div[@id='payersdispatch_slips']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']

# ----- Page_détails_Produits    -----
${BOUTON_CREER_PRIX_PRODUIT}                     xpath=//div[@id='productsproduct_prices']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_CREER_DATE_PEREMPTION_PRODUIT}         xpath=//div[@id='id="productsproduct_expiry_dates"']/div[@class='sob-v2-card-content']//div[@class='sob-v2-table-header-actions']/button[@data-testid='créer']
${BOUTON_DESACTIVER_PRODUIT}                     xpath=//*[@data-testid="désactiver"]
${BOUTON_MODIFIER_PRODUIT}                       xpath=//*[@data-testid="modifier"]
${BOUTON_AUTRE_ACTION_PRODUIT}                   xpath=//button[contains(., 'Autres actions')]

# --- Champs Liste Mise à jour des prix des produits ---
${CHAMP_NOM_MAJ_PRIX}                id=product_id_name
${CHAMP_PPV_MAJ_PRIX}                id=original_sale_price
${CHAMP_PPV_MAJ_MAJ_PRIX}            id=sale_price
${CHAMP_PPH_MAJ_PRIX}                id=original_purchase_price
${CHAMP_PPH_MAJ_MAJ_PRIX}            id=purchase_price
${BOUTON_AJOUTER_DEUXIEME_PRIX}      xpath=//*[@data-testid="ajouter_un_deuxième_prix"]
${BOUTON_REMPLACER_PRIX}             xpath=//*[@data-testid="remplacer_le_prix"]
${BOUTON_IGNORER_PRIX}               xpath=//*[@data-testid="ignorer"]

# --- Champs Liste Communication client ---
${CHAMP_CREE_PAR_COMMUNICATION}      id=created_by.q
${CHAMP_CREE_LE_COMMUNICATION}       id=created_on.q
${CHAMP_ENVOYER_A_COMMUNICATION}     id=sent_to
${CHAMP_MESSAGE_COMMUNICATION}       id=message
${CHAMP_CREDITS_UTILISES_COMMUNICATION}    id=credits_used
${CHAMP_STATUT_COMMUNICATION}        id=status.q
${BOUTON_ENVOYER_COMMUNICATION_GROUPEE}    xpath=//*[@data-testid="envoyer_une_communication_groupée"]
${ONGLET_SMS_COMMUNICATION}          xpath=//*[@data-testid="sms"]
${ONGLET_EMAILS_COMMUNICATION}       xpath=//*[@data-testid="e-mails"]

# --- Champs Liste MySobrus ---
${CHAMP_CLIENT_MYSOBRUS}             id=name
${CHAMP_TELEPHONE_MYSOBRUS}          id=phone
${CHAMP_SOLDE_MYSOBRUS}              id=balance
${BOUTON_PARAMETRES_PARTAGE_MYSOBRUS}    xpath=//*[@data-testid="paramètres_de_partage_d'information"]
${BOUTON_MON_QR_CODE_MYSOBRUS}       xpath=//*[@data-testid="mon_qr_code"]
${BOUTON_LIER_CLIENT_MYSOBRUS}       xpath=//*[@data-testid="lier_un_client"]

# --- Champs Liste Dépenses ---
${CHAMP_CATEGORIE_DEPENSE}           id=expense_category_id.q
${CHAMP_LIBELLE_DEPENSE}             id=label
${CHAMP_DATE_DEPENSE}                id=date.q
${CHAMP_MONTANT_DEPENSE}             id=amount
${CHAMP_STATUT_DEPENSE}              id=status.q
${BOUTON_IMPRIMER_DEPENSE}           xpath=//*[@data-testid="imprimer_"]


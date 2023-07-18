import LightningDatatable from 'lightning/datatable';
import plTemplate from './plTemplate.html';

export default class customDataTypes extends LightningDatatable {

        static customTypes = {
            customPLType: {
                template: plTemplate,
                standardCellLayout: true,
                typeAttributes: ['plValue', 'options']

            }

        }
}